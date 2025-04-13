
variable "instance_type" {
  description = "The instance type of the ec2 instances"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The ami id for the ec2 instances"
  type        = string
  default     = "ami-00a929b66ed6e0de6"
}

variable "availability_zone_one" {
  description = "The availability zone one for the subnet & ec2 instances"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_two" {
  description = "The availability zone two for the subnet & ec2 instances"
  type        = string
  default     = "us-east-1b"
}
