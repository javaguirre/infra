variable "profile" {
  default = "terraform_iam_user"
}

variable "region" {
  default = "eu-west-1"
}

variable "prestashop_key_name" {
  default = "javaguirre-tnp"
  description = "The first machines we deployed had an specific key pair we maintain now"
}

variable "key_name" {
  default = "javaguirre-tnp"
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "instance_count" {
  default = "1"
}


variable "ansible_user" {
  default = "ubuntu"
}

variable "ami" {
  default = "ami-04c58523038d79132"  # Ubuntu 18.04
}

variable "ec2_size" {
  default = "t2.medium"
}
