# modules/security/main.tf - ONLY SECURITY GROUPS

# 1. Nginx Security Group
resource "aws_security_group" "nginx_sg" {
  name        = "${var.env_prefix}-nginx-sg"
  description = "Allow SSH from my IP, HTTP/S from anywhere"
  vpc_id      = var.vpc_id

  # Ingress: Port 22 (SSH) from your IP only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Ingress: Port 80 (HTTP) from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Egress: All traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, { Name = "${var.env_prefix}-nginx-sg" })
}

# 2. Backend Security Group
resource "aws_security_group" "backend_sg" {
  name        = "${var.env_prefix}-backend-sg"
  description = "Allow SSH from my IP, HTTP from Nginx SG only"
  vpc_id      = var.vpc_id

  # Ingress: Port 22 (SSH) from your IP only (for you to debug)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # --- CRITICAL FIX ADDED HERE ---
  # Ingress: Port 22 (SSH) from NGINX Security Group ONLY (for jump host access)
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.nginx_sg.id] # Source is Nginx SG ID
  }
  # --- END CRITICAL FIX ---

  # Ingress: Port 80 (HTTP) from Nginx security group ONLY
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.nginx_sg.id] # Source is Nginx SG ID
  }

  # Egress: All traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, { Name = "${var.env_prefix}-backend-sg" })
}