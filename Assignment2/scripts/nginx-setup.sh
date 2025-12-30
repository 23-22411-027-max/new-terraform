#!/bin/bash
# Update the system packages
yum update -y

# Install Nginx
amazon-linux-extras enable nginx1
yum install -y nginx

# Start Nginx service
systemctl start nginx
systemctl enable nginx

# Create a simple index.html
echo "<h1>Welcome to Nginx on $(hostname)</h1>" > /usr/share/nginx/html/index.html

# Allow HTTP on firewall (optional for Amazon Linux)
if command -v firewall-cmd >/dev/null 2>&1; then
  firewall-cmd --zone=public --add-service=http --permanent
  firewall-cmd --reload
fi
