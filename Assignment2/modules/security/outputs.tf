# modules/security/outputs.tf

output "nginx_sg_id" {
  description = "ID of the Security Group for the Nginx proxy"
  value       = aws_security_group.nginx_sg.id
}

output "backend_sg_id" {
  description = "ID of the Security Group for the Backend web servers"
  value       = aws_security_group.backend_sg.id
}