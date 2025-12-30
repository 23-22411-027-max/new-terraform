# Root outputs.tf

output "nginx_public_ip" {
  description = "The public IP of the Nginx proxy server"
  value       = module.nginx_server.public_ip
}

output "backend_private_ips" {
  description = "A map of the backend server private IPs"
  # This uses the for_each loop structure for the backend_servers module
  value       = { for k, v in module.backend_servers : k => v.private_ip }
}