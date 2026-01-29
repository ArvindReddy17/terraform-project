variable "cidr" {
  description = "CIDR block of VPC"
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "name of the vpc"
  type = string
  default = "my-vpc"
}

variable "IGW_NAME" {
description = "IGW for my vpc"
type = string
default = "my-IGW"
}

variable "IPV4_PUB01" {
  description = "ipv4 for public subnet01"
  default = "10.0.1.0/24"
}

variable "IPV4_Pvt01" {
  description = "ipv4 for private subnet02"
  default = "10.0.2.0/24"
}

variable "pub-subnet-name" {
  description = "name of public subnet "
  default = "public-subnet-01"
}

variable "pvt-subnet-name" {
    description = "name of the pvt subnet"
    default = "private-subnet-01"
}

variable "NATgw" {
    description = "NAT GATEWAY info"
    default = "my-nat"
}


variable "Public-rt-name" {
    description = "name for public route table"
    default = "public-rt"
}

variable "private-rt-name" {
    description = "name for private route table"
    default = "private-rt"
}