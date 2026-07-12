variable "ami"{
    description = "image info number (you pick it from aws ) "
    type=string
}
variable "instance_type"{
    description = "from aws determine which type of image (e.g t3 or t2 or whatever)"
    type = string
}
variable "subnet_id" {}
variable "key_name"  {}
variable "security_group_id" {}
variable "instance_name" {
    description = "Name of your instance "
    type = string
}
