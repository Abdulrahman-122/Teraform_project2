resource "aws_db_subnet_group" "db"{
    name="gym-db-subnet-group"
    subnet_ids = var.private_subnets
    tags={
        Name="Gym DB subnet Group"
    }
}

resource "aws_db_instance" "db"{
    identifier = "gym-database"
    engine = "mariadb"
    instance_class ="db.t3.micro"
    allocated_storage = 20
    db_name = var.db_name
    username = var.db_username
    password = var.password
    db_subnet_group_name = aws_db_subnet_group.db.name
    vpc_security_group_ids = [var.security_group_id]
    publicly_accessible = false
    skip_final_snapshot = true
    tags = {
      Name="Gym Database"
    }
}