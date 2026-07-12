variable "launch_template_id" {}
variable "launch_template_version" {
  
}
variable "subnets" {
    type=list(string)
}
variable "target_group_arns" {
    type=list(string)
  
}