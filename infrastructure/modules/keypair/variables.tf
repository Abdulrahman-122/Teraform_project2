variable "key_name"{
    description = "A name for the .pem file in order to get into the instances"
    type=string
}
variable "public_key_path"{
    description = "The path of the public key on your pc in order to allow aws to use the value inside it and put it into the instances in order to ssh into them correctly"
    type=string
}