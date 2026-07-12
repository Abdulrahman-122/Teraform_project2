variable "private_subnets"{
    type = list(string)
}
variable "security_group_id" {
  type = string
}
variable "db_name" {
    type = string
}
variable "db_username" {
  type = string
  sensitive = true
}
variable "password" {
  type = string
  sensitive = true
}