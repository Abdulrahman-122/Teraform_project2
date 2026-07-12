output "launch_template_id" {
    value=aws_launch_template.build_another.id
}
output "launch_template_version" {
    value=aws_launch_template.build_another.latest_version
}