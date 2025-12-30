variable "vpc_id" {
  description = "The ID of the VPC to create security groups in."
  type        = string
}

variable "env_prefix" {
  description = "Environment prefix for naming resources."
  type        = string
}

variable "my_ip" {
  description = "Your public IP for SSH ingress (CIDR format)."
  type        = string
}

variable "common_tags" {
  description = "Common tags to assign to resources."
  type        = map(string)
}