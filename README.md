# Terraform Project
This repository contains terraform code to create the modules & resources in AWS cloud platform, to demonstrate Blue-Green deployments using Application Load Balancer.

## Network Module
The network module creates the following resources.
* VPC
* Subnets - 2 subnets for two availability zones
* Intenet gateway
* Route table & associate resources
* Security group allowing HTTP access

## Instance Module
The instance modules creates two ec2 instances with user data.

## Load Balancer Module
The load balancer module creates a load balancer with two target groups.

## Main Module
The main module actually calls the above child modules to create network, ec2 and load balancer resources.

## Verification
1. Two EC2 instances are created in a VPC, in us-east-1 region
![Network interfaces](images/image-1.png)
![Security groups](images/image-2.png)
![Blue EC2 instance - Details](images/image-3.png)
![Blue EC2 instance - Networking](images/image-4.png)

2. One load balancer is created, and targeted to Blue target group i.e. Blue EC2 instance
![Blue Target Group - Details](images/image-5.png)
![Blue Target Group - Targets](images/image-6.png)
![Load balancer - Details](images/image-7.png)

3. Access load balancer DNS name - displaying Blue deployment
![Terraform Apply - Output Variable](images/image-8.png)
![Access load balancer URL](images/image-9.png)

4. Update load balancer definition to Green targer group and apply terraform changes
![Blue EC2 instance - Details](images/image-10.png)
![Blue EC2 instance - Security](images/image-11.png)
![Blue EC2 instance - Networking](images/image-12.png)
![Green Target Group - Details](images/image-13.png)
![Green Target Group - Targets](images/image-14.png)
![Load balancer - Details](images/image-15.png)
![Load balancer - Listeners](images/image-16.png)

5. Access load balancer DNS name - displaying Green deployment
![Access load balancer URL](images/image-17.png)

6. Read Terraform state file and lock file, attached here for more details
