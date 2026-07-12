variable "region" {
  description = "Aws region"
  type=string
}
variable "vpc_cidr" {
    type=string
}
variable "public_subnet1" {
  type=string
}
variable "public_subnet2" {
  type=string
}
variable "private_subnet1" {
  type=string
}
variable "private_subnet2" {
  type=string
}
variable "key_name" {
    type=string
}
variable "public_key_path" {
  type=string
}
variable "ssh_cidr" {
  description = "Admin Ip allowed for ssh"
  type = string
}
variable "db_name" {
  type=string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type=string
  sensitive = true
}
variable "public_subnets" {
  type=list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
