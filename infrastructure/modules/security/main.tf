# this security group before load balancer

resource "aws_security_group" "alb" {
    name="gym-application-load-balancer"
    description = "security group for the load balancer"
    vpc_id = var.vpc_id
    ingress{
        description = "Allow http from the internet"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    ingress {
        description = "Allow Https from the internet"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow for instances to interact with internet"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name="gym-alb-sg"
    }
}



resource "aws_security_group" "sg_backend" {
    name="gym-security-backend"
    description = "security group for backend instances EC2"
    vpc_id = var.vpc_id
    ingress{
        description = "Allow ssh traffic that come from Administrator IP only"
        from_port=22
        to_port = 22
        protocol = "tcp"
        cidr_blocks=[var.ssh_cidr]

    }
    ingress{
        description = "Allow flask traffic that came from ALB only"
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        security_groups = [aws_security_group.alb.id]
    }
    ingress{
        from_port = 5173
        to_port = 5173
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # outbound traffic from instances to the internet 
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name="gym-backend-sg"
    }
}
resource "aws_security_group" "rds" {
    name="gym-rds-security-group"
    vpc_id = var.vpc_id
    ingress {
        description = "Allow mariadb from backend only"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.sg_backend.id]

    }
    egress {
        description = "allow outbound traffic" 
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name="gym-rds-sg"
    }
}