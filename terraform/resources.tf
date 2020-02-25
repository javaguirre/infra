resource "aws_instance" "prestashop_staging" {
  ami           = var.ami
  instance_type = var.ec2_size
  key_name      = var.prestashop_key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "prestashop-staging"
  }
}

resource "aws_instance" "prestashop_production" {
  ami           = var.ami
  instance_type = var.ec2_size
  key_name      = var.prestashop_key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "prestashop-production"
  }
}

resource "aws_security_group" "web" {
  name        = "default-web-prestashop"
  description = "Security group for web that allows web traffic from internet"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "default-ssh-prestashop"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "egress-tls" {
  name        = "default-egress-tls-prestashop"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ping-ICMP" {
  name        = "default-ping-prestashop"
  description = "Default security group that allows to ping the instance"

  ingress {
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "tnp-infra-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}
