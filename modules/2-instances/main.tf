
# Create EC2 instance for Blue deployment
resource "aws_instance" "blue" {
  ami               = var.ami_id # Amazon Linux 2023
  instance_type     = var.instance_type
  subnet_id         = var.blue_subnet_id
  availability_zone = var.availability_zone_one # Specify the availability zone
  security_groups   = [var.security_group_id]

  user_data = <<-EOF
            #!/bin/bash
            amazon-linux-extras enable nginx1
            yum install -y nginx
            systemctl start nginx
            systemctl enable nginx
            echo "<html><body style='background-color:blue;'><h1>Blue Environment</h1></body></html>" > /usr/share/nginx/html/index.html
            EOF

  tags = {
    Name = "Blue-Instance"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create EC2 instance for Green deployment
resource "aws_instance" "green" {
  ami               = var.ami_id # Amazon Linux 2023
  instance_type     = var.instance_type
  subnet_id         = var.green_subnet_id
  availability_zone = var.availability_zone_two # Specify the availability zone
  security_groups   = [var.security_group_id]

  user_data = <<-EOF
            #!/bin/bash
            amazon-linux-extras enable nginx1
            yum install -y nginx
            systemctl start nginx
            systemctl enable nginx
            echo "<html><body style='background-color:green;'><h1>Green Environment</h1></body></html>" > /usr/share/nginx/html/index.html
            EOF

  tags = {
    Name = "Green-Instance"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Output variable for Blue EC2 instance id
output "blue_instance_id" {
  value = aws_instance.blue.id
}

# Output variable for Green EC2 instance id
output "green_instance_id" {
  value = aws_instance.green.id
}