variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone to deploy resources"
  type        = string
  default     = "me-central-1a"
}

variable "env_prefix" {
  description = "Environment prefix for naming resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "public_key" {
  description = "Path to the SSH public key file (~/.ssh/id_ed25519.pub)"
  type        = string
}

variable "private_key" {
  description = "Path to the SSH private key file (~/.ssh/id_ed25519)"
  type        = string
}

variable "region" {
  description = "AWS Region for deployment"
  type        = string
  default     = "me-central-1"
}