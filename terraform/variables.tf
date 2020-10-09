variable "profile" {
  default = "terraform_iam_user"
}

variable "region" {
  default = "eu-central-1"
}

variable "prestashop_key_name" {
  default = "prestashop-tnp"
  description = "The first machines we deployed had an specific key pair we maintain now"
}

variable "key_name" {
  default = "terraform-tnp"
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
  default = "ami-04b15ea61eae36f54"
}

variable "wordpress_ami" {
  default = "ami-0eabb053fd6dcde27"
}

variable "ec2_size" {
  default = "t2.medium"
}
