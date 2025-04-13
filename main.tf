
# Terraform block for Terraform version and AWS provider version etc.
terraform {
  required_version = ">= 1.11.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.94.0"

    }
  }
}

# AWS provider specific settings
provider "aws" {
  region     = "us-east-1"
  access_key = "deleted"
  secret_key = "deleted"
}

# Calling network module
module "network" {
  source = "./modules/1-network"
}

# Calling EC2 instances module
module "instances" {
  source                = "./modules/2-instances"
  blue_subnet_id        = module.network.blue_subnet_id
  green_subnet_id       = module.network.green_subnet_id
  security_group_id     = module.network.security_group_id
  instance_type         = var.instance_type
  ami_id                = var.ami_id
  availability_zone_one = var.availability_zone_one
  availability_zone_two = var.availability_zone_two
}

# Calling load balancer module
module "load_balancer" {
  source            = "./modules/3-load_balancer"
  vpc_id            = module.network.vpc_id
  blue_subnet_id    = module.network.blue_subnet_id
  green_subnet_id   = module.network.green_subnet_id
  security_group_id = module.network.security_group_id
  blue_instance_id  = module.instances.blue_instance_id
  green_instance_id = module.instances.green_instance_id
}

# Output variable for load balancer DNS name
output "blue-green-alb_dns_name" {
  value = module.load_balancer.blue-green-alb_dns_name
}