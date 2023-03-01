#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#sg
variable "outputs_sg_sg_kafka_id" {}
#vpc
variable "outputs_vpc_public_subnets" {}
#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {}
#------------------------------------------------------------------------------
# Kafka variables
#------------------------------------------------------------------------------
#TODO
variable "subnet_numbers" {
  description = "Map from availability zone to the number that should be used for each availability zone's subnet"
  type        = map(string)
  default = {
    "eu-central-1a" = 1
    "eu-central-1b" = 2
    "eu-central-1c" = 3
  }
}
variable "kafka_version" {
  type        = string
  description = "Version of Kafka brokers"
  default     = "2.6.2"
}
variable "kafka_broker_number" {
  type        = number
  description = "Kafka brokers per zone"
  default     = 2
}
variable "kafka_instance_type" {
  type        = string
  description = "Kafka broker instance type"
  default     = "kafka.t3.small"
}
variable "kafka_ebs_volume_size" {
  type        = string
  description = "Kafka EBS volume size in GB"
  default     = "100"
}
variable "kafka_encryption_in_transit" {
  type        = string
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT."
  default     = "TLS_PLAINTEXT"
}
variable "kafka_monitoring_level" {
  type        = string
  description = "property to one of three monitoring levels: DEFAULT, PER_BROKER, or PER_TOPIC_PER_BROKER"
  default     = "PER_TOPIC_PER_BROKER"
}
variable "kafka_custom_config" {
  type        = string
  default     = "{}"
  description = "Kafka custom config json file"
}
variable "allowed_cidr" {
  description = "A list of CIDR Networks to allow ssh access to."
  type        = list(string)

  default = [
    "0.0.0.0/0",
  ]
}
variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources"
  type        = map(string)
  default     = {}
}