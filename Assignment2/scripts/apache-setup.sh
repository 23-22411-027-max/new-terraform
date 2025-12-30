#!/bin/bash
# Update the system packages
yum update -y

# Install Apache HTTP Server
yum install -y httpd

# Start Apache service
systemctl start httpd
systemctl enable httpd

# Create a unique index.html that shows the server's private IP
SERVER_IP=$(hostname -I | awk '{print $1}')
echo "<h1>Welcome to Apache on ip-${SERVER_IP}</h1>" > /var/www/html/index.html