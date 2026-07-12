output "target_group_arn" {
    value=aws_lb_target_group.backend.arn
}
output "aws_dns_name" {
    value=aws_lb.load_balancer.dns_name
}
output "alb_arn"{
    value=aws_lb.load_balancer.arn
}
