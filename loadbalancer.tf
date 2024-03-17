resource "aws_lb" "public_lb" {
  name               = "public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_c.id]
}

resource "aws_lb_target_group" "instances_tg" {
  name     = "instances-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terra_vpc.id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instances_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "attach_instances_a" {
  target_group_arn = aws_lb_target_group.instances_tg.arn
  target_id        = aws_instance.web_server_a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_instances_c" {
  target_group_arn = aws_lb_target_group.instances_tg.arn
  target_id        = aws_instance.web_server_c.id
  port             = 80
}
