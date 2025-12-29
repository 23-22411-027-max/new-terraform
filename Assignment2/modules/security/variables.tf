variable "vpc_id" {
  type        = string
  description = "VPC ID where security groups will be created"
}

variable "env_prefix" {
  type        = string
  description = "Environment prefix"
}

variable "my_ip" {
  type        = string
  description = "Your public IP with /32 for SSH access"
}
