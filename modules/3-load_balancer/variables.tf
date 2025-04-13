variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be deployed"
  type        = string
}

variable "blue_subnet_id" {
  description = "The ID of the blue subnet where the load balancer will be deployed"
  type        = string
}

variable "green_subnet_id" {
  description = "The ID of the green subnet where the load balancer will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the load balancer"
  type        = string
}

variable "blue_instance_id" {
  description = "The ID of the Blue EC2 instance"
  type        = string
}

variable "green_instance_id" {
  description = "The ID of the Green EC2 instance"
  type        = string
}