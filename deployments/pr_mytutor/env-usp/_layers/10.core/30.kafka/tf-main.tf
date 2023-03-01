#--------------------------------------------------------------
# General
#--------------------------------------------------------------

#tables
#schemes
#modules
#resources
#diagrams


# Dependencies Structure
# ├── aws_msk_cluster                                                               
# │   ├── aws_vpc                                                  
# │   │   ├── aws_availability_zones                                                            
# │   │   ├── aws_subnet.1                                                           
# │   │   ├── aws_subnet.2
# │   │   ├── aws_subnet.3
# │   │   ├── aws_subnet.4                                                             
# │   ├── aws_security_group                                                 
# │   ├── aws_kms_key
# │   ├── aws_cloudwatch_log_group
# │   ├── aws_s3_bucket
# │   │   ├── aws_s3_bucket_acl                                                             
# │   └──|
# └──| 

#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_id" "cdn" {
  byte_length = 4
}

#--------------------------------------------------------------
# Kafka
#--------------------------------------------------------------
resource "aws_msk_cluster" "msk-cluster" {
  cluster_name           = "${module.label.id}-msk-cluster"
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.kafka_broker_number
  enhanced_monitoring    = var.kafka_monitoring_level
  tags                   = module.label.tags
  broker_node_group_info {
    instance_type   = var.kafka_instance_type
    ebs_volume_size = var.kafka_ebs_volume_size
    client_subnets  = var.outputs_vpc_public_subnets
    security_groups = [var.outputs_sg_sg_kafka_id]
  }
  encryption_info {
    encryption_in_transit {
      client_broker = var.kafka_encryption_in_transit
    }
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
  }
  configuration_info {
    arn      = "${aws_msk_configuration.mks-cluster-custom-configuration.arn}"
    revision = "${aws_msk_configuration.mks-cluster-custom-configuration.latest_revision}"
  }
  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }
  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.kafka_log_group.name
      }
      s3 {
        enabled = true
        bucket  = aws_s3_bucket.bucket.id
        prefix  = "logs/msk-"
      }
    }
  }
}

resource "aws_msk_configuration" "mks-cluster-custom-configuration" {
  kafka_versions = [var.kafka_version]
  name           = "${module.label.id}-mks-cluster-custom-configuration"
  server_properties = <<PROPERTIES
    auto.create.topics.enable                 = true
    delete.topic.enable                       = true
    transaction.state.log.min.isr             = 1
    transaction.state.log.replication.factor  = 1
    replica.fetch.max.bytes                   =10485760
    message.max.bytes                         =10485760
    socket.receive.buffer.bytes               =10485760
    socket.request.max.bytes                  =10485760
    socket.send.buffer.bytes                  =10485760
    PROPERTIES
}

#--------------------------------------------------------------
# KMS
#--------------------------------------------------------------
resource "aws_kms_key" "kms" {
  description = "${module.label.id}_msk_cluster_kms_key"
  tags        = module.label.tags
}

#--------------------------------------------------------------
# Logging
#--------------------------------------------------------------
resource "aws_cloudwatch_log_group" "kafka_log_group" {
  name = "${module.label.id}_msk_broker_logs"
  tags = module.label.tags
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${module.label.id}-broker-logs-${random_id.cdn.dec}"
  tags   = module.label.tags
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}