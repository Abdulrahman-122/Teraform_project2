variable "vpc_id" {
    description = "Id of Vpc "
    type=string
}
# we will take it from networking module inside environment 
variable "ssh_cidr" {
    description = "CIDR(your ip or admin ip) in order to ssh into this machine"
    type=string
}