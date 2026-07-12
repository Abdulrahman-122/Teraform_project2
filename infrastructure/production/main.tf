module "network" {
    source = "../modules/networking"
    vpc_main = var.vpc_cidr
    public_subnet1_cidr = var.public_subnet1
    public_subnet2_cidr = var.public_subnet2
    private_subnet1_cidr = var.private_subnet1
    private_subnet2_cidr = var.private_subnet2
    region = var.region
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
}
module "keypair" {
  source = "../modules/keypair"
  key_name = var.key_name
  public_key_path = var.public_key_path
}
module "security" {
  source = "../modules/security"
  vpc_id = module.network.vpc_id
  ssh_cidr = var.ssh_cidr
}
module "rds" {
    source = "../modules/rds"
    private_subnets = module.network.private_subnets
    security_group_id = module.security.rds_security_group_id
    db_name = var.db_name
    db_username = var.db_username
    password = var.db_password
  
}
module "alb" {
    source = "../modules/alb"
    vpc_id = module.network.vpc_id
    public_subnets =module.network.public_subnets
    security_group_id = module.security.aws_security_group_alb_id
  
}
module "launch_template" {
    source = "../modules/launch_template"
    ami = var.ami
    instance_type = var.instance_type
    key_name = module.keypair.key_name
    security_group_id = module.security.aws_security_group_backend_id
    user_data = templatefile(
        "${path.module}/user_data.sh",
            {
            db_endpoint = module.rds.db_endpoint
            db_name     = var.db_name
            db_username = var.db_username
            db_password = var.db_password
            }
    )
}
module "autoscaling" {
    source = "../modules/autoscaling"
    launch_template_id = module.launch_template.launch_template_id
    launch_template_version =module.launch_template.launch_template_version
    subnets = module.network.public_subnets
    target_group_arns = module.alb.target_group_arn


}

module "waf" {
    source="../modules/waf"
    alb_arn = module.alb.alb_arn
  
}