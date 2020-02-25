terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "tnp-infra"
    key = "global/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "tnp-infra-locks"
    encrypt = true
  }
}
