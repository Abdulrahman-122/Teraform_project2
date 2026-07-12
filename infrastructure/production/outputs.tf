output "alb_dns_name" {
    value = module.alb.aws_dns_name
}
output "database_endpoint" {
    value = module.rds.db_endpoint
}
