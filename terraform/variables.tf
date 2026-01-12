variable "aws_region" {
  description = "Region chosen for the VPC"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR chosen for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the ec2"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

variable "my_ip" {
  description = "My public IP for SSH and Flask access"
  type        = string
}
