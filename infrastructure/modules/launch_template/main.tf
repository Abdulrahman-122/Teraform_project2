resource "aws_launch_template" "build_another" {
    name_prefix = "gym-backend-"
    image_id = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [var.security_group_id]
    user_data = var.user_data
    update_default_version = true
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "Gym Backend"
      }
    }
  
}