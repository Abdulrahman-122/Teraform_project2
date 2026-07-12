variable "vpc_main" {
  description="Virtual private cloud for secure the whole infrastructure"
  type=string
}
variable "public_subnet1_cidr" {
  description = "A range of ips for 1st subnet (public)"
}
variable "public_subnet2_cidr"{
    description = "A range of ips for 1st subnet (public)"

}
variable "region"{
    description = "Aws region"
    type=string
}
variable "private_subnet1_cidr" {
  type=string
}
variable "private_subnet2_cidr"{
  type=string
}
variable "public_subnets" {
  type = list(string)
  
}
variable "private_subnets" {
  type = list(string)
}