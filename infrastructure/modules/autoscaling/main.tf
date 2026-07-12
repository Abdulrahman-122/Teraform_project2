resource "aws_autoscaling_group" "new_ec2" {
    name="Gym_autoscaling"
    min_size = 2
    max_size = 4
    desired_capacity = 2
    vpc_zone_identifier = var.subnets
    target_group_arns = var.target_group_arns
    launch_template {
      id=var.launch_template_id
      version=var.launch_template_version
    }
    health_check_type = "ELB"
    health_check_grace_period = 120
    force_delete = true
}
# write the policies 
resource "aws_autoscaling_policy" "scale_out" {
    name="gym-scale-out"
    autoscaling_group_name = aws_autoscaling_group.new_ec2.name
    adjustment_type="ChangeInCapacity"
    scaling_adjustment = 1
    cooldown=300  

}
resource "aws_autoscaling_policy" "scale_in"{
    name="gym-scale-in"
    autoscaling_group_name=aws_autoscaling_group.new_ec2.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = -1
    cooldown = 300
}
# use cloudwatch Alarm to trigger these policies as they can't trigger themselfs
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
    alarm_name="gym-high-cpu"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period=120
    statistic = "Average"
    threshold=70
    dimensions = {
      AutoScalingGroupName=aws_autoscaling_group.new_ec2.name
    }
    alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}
resource "aws_cloudwatch_metric_alarm" "low_cpu"{
    alarm_name="gym-low-cpu"
    comparison_operator = "LessThanThreshold"
    evaluation_periods=2
    metric_name="CPUUtilization"
    namespace = "AWS/EC2"
    period=120
    statistic = "Average"
    threshold=20
    dimensions = {
      AutoScalingGroupName=aws_autoscaling_group.new_ec2.name
    }
    alarm_actions=[aws_autoscaling_policy.scale_in.arn]
}