# Provider variables
variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "aws_region" {
  default = "eu-west-1"
}

# Servers variables
variable "alastria_ami" {
  default = "ami-04c58523038d79132" # Ubuntu 18.04
}

variable "alastria_instance_size" {
  default = "t2.medium"
}

variable "key_name" {
  default = ""
}
