provider "aws" {
  version = "~> 2.42"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region  = var.aws_region
}
