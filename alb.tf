resource "aws_security_group" "my_security_group" {
  name        = "Dynamic-my-security-group"
  description = "My Security Group"
  vpc_id      = aws_vpc.myvpc.id
  dynamic "ingress" {
    for_each = ["443", "80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraformVpc"
  }
}

resource "aws_lb_target_group" "my-target-group" {
  # health_check {
  #   interval            = 10
  #   path                = "/"
  #   protocol            = "HTTP"
  #   timeout             = 5
  #   healthy_threshold   = 5
  #   unhealthy_threshold = 2
  # }

  name        = "test-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.myvpc.id
}


resource "aws_lb" "my-load-balancer" {
  name     = "test-name-lb"
  internal = false

  security_groups = [aws_security_group.my_security_group.id]

  subnets = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet2.id]

  ip_address_type    = "ipv4"
  load_balancer_type = "application"

}

resource "aws_lb_listener" "my-lb-listener" {
  load_balancer_arn = aws_lb.my-load-balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener" "my-lb-listener1" {
  load_balancer_arn = aws_lb.my-load-balancer.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.certificate.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-target-group.arn
  }
}
