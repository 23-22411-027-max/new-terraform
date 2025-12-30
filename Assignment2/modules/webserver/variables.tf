# modules/webserver/variables.tf

variable "env_prefix" {
  description = "Environment prefix for resource naming"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone to deploy instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the instance will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to attach"
  type        = string
}

variable "public_key" {
  description = "Path to the SSH public key file for the key pair"
  type        = string
}

variable "script_path" {
  description = "Path to the user-data script for instance setup"
  type        = string
}

variable "instance_suffix" {
  description = "A unique suffix (like 'nginx' or '1') for the key pair and instance"
  type        = string
}

variable "common_tags" {
  description = "Common tags to assign to resources"
  type        = map(string)
}

# CRITICAL: AMI is required but missing a definition or a default value
variable "ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string
  # --- FIX THIS LINE ---
  default     = "ami-0b925567b5e43818e" # New Amazon Linux 2023 AMI for me-central-1 (Dubai)
}