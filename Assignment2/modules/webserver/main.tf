resource "aws_key_pair" "this" {
  key_name   = "my-key-2"
  public_key = file(var.public_key)
}



# Launch EC2 instance
resource "aws_instance" "this" {
  ami                         = "ami-0d08f203d3be66c86" # Amazon Linux 2023 (update if needed)
  instance_type               = var.instance_type
  availability_zone           = var.availability_zone
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  # Run server setup script
  user_data = file(var.script_path)

  tags = merge(
    var.common_tags,
    {
      Name = "${var.env_prefix}-${var.instance_name}-${var.instance_suffix}"
    }
  )
}
