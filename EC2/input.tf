variable "ec2_name" {
  description = "name for ec2"
  default = "my-ec2"
}

variable "instance_typee" {
  description = "instance_type of EC2"
  type = string
  default = "t2.large"
}

variable "AMI_ID" {
  description = "AMI ID for ec2 instance"
  type = string
  default = "ami-0532be01f26a3de55"
}

variable "KEY_PAIR" {
  description = "key pair name"
  default = "ec2-key"
}

variable "public_subnet" {
description = "public subnet id for ec2 creation"
type = string
}

variable "VPC_ID" {
    description ="vpc ID for subnet creation"
    type = string
}