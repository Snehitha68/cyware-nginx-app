
# Create an Application Load Balancer
resource "aws_lb" "nginx_lb" {
  name               = "nginx-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.cywarevpcpublicsubnets : subnet.id]
  security_groups    = [aws_security_group.alb_sg.id]

  enable_deletion_protection = false

  tags = merge(var.commantags,
    {
      "Name" = "cyware-alb"
    }
  )
}

# Create a target group for the load balancer to route traffic to
resource "aws_lb_target_group" "nginx_target_group" {
  name        = "nginx-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.cywarevpc.id # Replace with your desired VPC ID

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 10
    path                = "/"
  }
}

# Register the EC2 instance as a target for the target group
resource "aws_lb_target_group_attachment" "nginx_attachment" {
  target_group_arn = aws_lb_target_group.nginx_target_group.arn
  count            = length(var.publicssubentscidrs)
  target_id        = aws_instance.nginxserver[count.index].private_ip
}

# Create a listener for the load balancer to route traffic to the target group
resource "aws_lb_listener" "nginx_listener" {
  count             = length(var.publicssubentscidrs)
  load_balancer_arn = element(aws_lb.nginx_lb[*].arn, count.index)
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.nginx_target_group.arn
    type             = "forward"
  }
}


