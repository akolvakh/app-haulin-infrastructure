#--------------------------------------------------------------
# Kafka SG
#--------------------------------------------------------------
module "kafka_sg" {
  source = "../../../../../../libft/generic-modules/sg"
  vpc_id = var.outputs_vpc_vpc_id
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow connections all (for now) services to Kafka"
      from_port        = 9094
      to_port          = 9094
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow connections all (for now) services to Kafka"
      from_port        = 9092
      to_port          = 9092
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow connections all (for now) services to Kafka"
      from_port        = 2181
      to_port          = 2181
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow connections all (for now) services to Kafka"
      from_port        = 9194
      to_port          = 9194
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow connections all (for now) services to Kafka"
      from_port        = 9196
      to_port          = 9196
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow connections all (for now) services to Kafka"
      from_port        = 9198
      to_port          = 9198
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    }
  ]
  egress = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      description = "Kafka to All."
      from_port        = 0
      to_port          = 0 //65535
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      prefix_list_ids  = []
      protocol         = "ALL"
      security_groups  = []
    }
  ]
  tag_role           = "kafka-sg"
  tag_description    = "MSK security group (only 9092, 9094 and  2181 inbound access is allowed)"
  sg_additional_tags = module.label.tags
  label              = module.label.tags
}