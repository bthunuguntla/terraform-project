
# Create a load balancer for Blue / Green deployment
resource "aws_lb" "main" {
  name               = "blue-green-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.blue_subnet_id, var.green_subnet_id] # Use both blue and green subnets
  tags = {
    Name = "blue-green-alb"
  }
}

# # Create a target group for Blue deployment
# resource "aws_lb_target_group" "blue" {
#   name     = "blue-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id

#   health_check {
#     path                = "/"
#     protocol            = "HTTP"
#     matcher             = "200"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#   }
# }

# # Create a listener for Blue deployment target group & load balancer
# resource "aws_lb_listener" "blue" {
#   load_balancer_arn = aws_lb.main.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.blue.arn
#   }
# }

# # Attach Blue deployment target group to Blue EC2 instance
# resource "aws_lb_target_group_attachment" "blue" {
#   target_group_arn = aws_lb_target_group.blue.arn
#   target_id        = var.blue_instance_id
#   port             = 80
# }

# Create a target group for Green deployment
resource "aws_lb_target_group" "green" {
  name     = "green-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

# Create a listener for Green deployment target group & load balancer
resource "aws_lb_listener" "green" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }
}

# Attach Green deployment target group to Green EC2 instance
resource "aws_lb_target_group_attachment" "green" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = var.green_instance_id
  port             = 80
}

# Output variable for load balancer DNS name
output "blue-green-alb_dns_name" {
  value = aws_lb.main.dns_name
}