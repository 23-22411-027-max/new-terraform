# AWS region
variable "region" {
  description = "AWS region for resources"
  default     = "me-central-1"
}

# Network variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.10.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for subnet"
  type        = string
  default     = "me-central-1a"
}

# Environment prefix
variable "env_prefix" {
  description = "Environment prefix"
  type        = string
  default     = "prod"
}

# EC2 instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# SSH key paths
variable "public_key" {
  description = "Path to public key file"
  default     = "/home/codespace/.ssh/id_ed25519.pub"
}

variable "private_key" {
  description = "Path to private key file"
  default     = "/home/codespace/.ssh/id_ed25519"
}


# Backend servers list
variable "backend_servers" {
  description = "List of backend servers"
  type = list(object({
    name       = string
    script_path = string
    suffix     = string
  }))
  default = [
    { name = "web-1", script_path = "./scripts/apache-setup.sh", suffix = "1" },
    { name = "web-2", script_path = "./scripts/apache-setup.sh", suffix = "2" },
    { name = "web-3", script_path = "./scripts/apache-setup.sh", suffix = "3" },
  ]
}
