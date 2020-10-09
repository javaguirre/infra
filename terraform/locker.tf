resource "aws_instance" "locker_wordpress" {
  ami           = var.wordpress_ami
  instance_type = var.ec2_size
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ftp.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "locker-wordpress"
  }
}

resource "aws_security_group" "ftp" {
  name        = "ftp"
  description = "FTP security group"

  ingress {
    from_port        = 21
    to_port          = 21
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
