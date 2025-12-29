variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for subnet"
}

variable "env_prefix" {
  type        = string
  description = "Environment prefix for naming resources"
}
variable "region" {
  description = "AWS region for networking resources"
  type        = string
}
