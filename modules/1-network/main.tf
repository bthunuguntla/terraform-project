
# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "blue-green-vpc"
  }
}

# Create a subnet for Blue deployment
resource "aws_subnet" "blue" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" # Subnet in the availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "blue-subnet"
  }
}

# Create a subnet for Green deployment
resource "aws_subnet" "green" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b" # Subnet in the availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "green-subnet"
  }
}

# Create internet gateway for VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "blue-green-igw"
  }
}

# Create a route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "blue-green-route-table"
  }
}

# Create a route allowing for internet access
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate route table to Blue subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.blue.id
  route_table_id = aws_route_table.main.id
}

# Associate route table to Green subnet
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.green.id
  route_table_id = aws_route_table.main.id
}

# Create a security group for allowing HTTP access
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Output variable for VPC id
output "vpc_id" {
  value = aws_vpc.main.id
}

# Output variable for Blue subnet id
output "blue_subnet_id" {
  value = aws_subnet.blue.id
}

# Output variable for Green subnet id
output "green_subnet_id" {
  value = aws_subnet.green.id
}

# Output variable for security group id
output "security_group_id" {
  value = aws_security_group.allow_http.id
}
