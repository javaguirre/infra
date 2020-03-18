variable "alastria_ami" {
  default = "ami-04c58523038d79132" # Ubuntu 18.04
}

variable "alastria_instance_size" {
  default = "t2.medium"
}

variable "alastria_key_name" {
  default = "alastria_tnp_bootnode"
}
