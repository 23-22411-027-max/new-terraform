terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.region
}

# 1. NETWORKING MODULE (VPC, Subnet, IGW, Route Table)
module "networking" {
  source              = "./modules/networking"
  vpc_cidr_block      = var.vpc_cidr_block
  subnet_cidr_block   = var.subnet_cidr_block
  availability_zone   = var.availability_zone
  env_prefix          = var.env_prefix
  common_tags         = local.common_tags
  region              = var.region # Ensure region is passed (to satisfy networking module variable)
}

# 2. SECURITY MODULE (Nginx SG, Backend SG)
module "security" {
  source      = "./modules/security"
  vpc_id      = module.networking.vpc_id # Correctly sourced from networking module
  env_prefix  = var.env_prefix
  my_ip       = local.my_ip 
  common_tags = local.common_tags
}

# 3. NGINX SERVER MODULE (Single instance)
module "nginx_server" {
  source            = "./modules/webserver"
  env_prefix        = var.env_prefix
  instance_name     = "nginx-proxy"
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  
  vpc_id            = module.networking.vpc_id
  subnet_id         = module.networking.subnet_id
  security_group_id = module.security.nginx_sg_id
  public_key        = var.public_key
  
  instance_suffix   = "nginx"
  script_path       = "./scripts/nginx-setup.sh"
  common_tags       = local.common_tags
}

# 4. BACKEND SERVERS MODULE (Multiple instances using for_each)
module "backend_servers" {
  for_each = { for server in local.backend_servers : server.name => server }
  
  source            = "./modules/webserver"
  env_prefix        = var.env_prefix
  instance_name     = each.value.name
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  
  vpc_id            = module.networking.vpc_id
  subnet_id         = module.networking.subnet_id
  security_group_id = module.security.backend_sg_id
  public_key        = var.public_key
  
  script_path       = each.value.script_path
  instance_suffix   = each.value.suffix
  common_tags       = local.common_tags
}