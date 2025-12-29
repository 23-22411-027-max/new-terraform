output "nginx_sg_id" {
  value       = aws_security_group.nginx_sg.id
  description = "Nginx security group ID"
}

output "backend_sg_id" {
  value       = aws_security_group.backend_sg.id
  description = "Backend security group ID"
}
