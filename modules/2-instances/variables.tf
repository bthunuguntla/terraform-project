variable "blue_subnet_id" {
  description = "The ID of the blue subnet where the load balancer will be deployed"
  type        = string
}

variable "green_subnet_id" {
  description = "The ID of the green subnet where the load balancer will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type of the ec2 instances"
  type        = string
}

variable "ami_id" {
  description = "The ami id for the ec2 instances"
  type        = string
}

variable "availability_zone_one" {
  description = "The availability zone one for the subnet & ec2 instances"
  type        = string
}

variable "availability_zone_two" {
  description = "The availability zone two for the subnet & ec2 instances"
  type        = string
}