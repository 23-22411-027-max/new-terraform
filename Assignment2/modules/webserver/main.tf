# modules/webserver/main.tf (Add this data source at the top)
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
# modules/webserver/main.tf

# 1. AWS Key Pair (unique per instance using suffix)
resource "aws_key_pair" "instance_key" {
  key_name   = "${var.env_prefix}-${var.instance_name}-${var.instance_suffix}-key"
  public_key = file(var.public_key)
}

# 2. EC2 Instance
resource "aws_instance" "web" {
  ami             = data.aws_ami.amazon_linux_2023.id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  # Ensure the availability zone is correctly passed
  availability_zone = var.availability_zone 
  vpc_security_group_ids = [var.security_group_id]
  key_name        = aws_key_pair.instance_key.key_name
  
  # user_data from script file
  user_data       = file(var.script_path) 
  
  # Tags
  tags = merge(
    var.common_tags,
    {
      Name = "${var.env_prefix}-${var.instance_name}"
    }
  )
}