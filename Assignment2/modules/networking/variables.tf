# modules/networking/variables.tf

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "env_prefix" {
  description = "Environment prefix for resource naming"
  type        = string
}

variable "common_tags" { # <-- FIX: This variable was missing or misspelled!
  description = "Common tags to apply to all networking resources"
  type        = map(string)
}

# CRITICAL FIX: The networking module needs the region.
# It can be passed directly, or you can use data sources, but since
# the error says it's missing, let's explicitly define it.

variable "region" { # <-- FIX: This variable was missing!
  description = "AWS Region to deploy resources into"
  type        = string
}