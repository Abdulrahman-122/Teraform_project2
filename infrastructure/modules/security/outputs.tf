output "aws_security_group_alb_id" {
    value = aws_security_group.alb.id
    description = "security group ID for the ALB"
}

output "aws_security_group_backend_id" {
    description = "security group ID for backend EC2 instances"
    value = aws_security_group.sg_backend.id
}
output "rds_security_group_id" {
    value = aws_security_group.rds.id
}