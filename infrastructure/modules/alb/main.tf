resource "aws_lb" "load_balancer"{
    name="gym-alb"
    load_balancer_type = "application"
    internal=false
    security_groups = [var.security_group_id]
    subnets=var.public_subnets
}
resource "aws_lb_target_group" "backend" {

  name = "gym-target"

  port = 5000

  protocol = "HTTP"

  vpc_id = var.vpc_id

  health_check {

    path = "/health"

    protocol = "HTTP"

    healthy_threshold = 2

    unhealthy_threshold = 2
    interval = 30
    timeout = 5

  }

}
resource "aws_lb_listener" "Http" {
    load_balancer_arn = aws_lb.load_balancer.arn
    port=80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn =aws_lb_target_group.backend.arn
    }
  
}