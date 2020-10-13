resource "aws_eip" "clevernet_vpn_eip" {
  instance = aws_instance.clevernet_vpn.id
  vpc      = true
  provider = aws.euwest3
}

resource "aws_security_group" "clevernet_vpn" {
  name        = "clevernet-vpn"
  description = "Clevernet VPN ports"
  provider    = aws.euwest3

  ingress {
    from_port   = 20000
    to_port     = 20003
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_paris" {
  name        = "default-ssh-prestashop"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"
  provider    = aws.euwest3

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "egress-tls_paris" {
  name        = "default-egress-tls-prestashop"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  provider    = aws.euwest3

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "clevernet_vpn" {
  ami               = "ami-0e61d96fec1d6004b"
  instance_type     = "m5.xlarge"
  key_name          = "javaguirre-tnp"
  source_dest_check = false
  provider          = aws.euwest3

  vpc_security_group_ids = [
    aws_security_group.ssh_paris.id,
    aws_security_group.egress-tls_paris.id,
    aws_security_group.clevernet_vpn.id,
  ]

  tags = {
    Name = "clevernet-vpn"
  }
}
