variable "subnet_ids" {}

variable "security_group_id" {}

variable "env" {}

variable "instance_name" {}

variable "ami" {}

variable "instance_count" {
    default = 1
}

variable "instance_type" {
    default = "t2.micro"
}