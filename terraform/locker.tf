resource "aws_instance" "locker_wordpress" {
  ami           = var.wordpress_ami
  instance_type = var.ec2_size
  key_name      = var.prestashop_key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "locker-wordpress"
  }
}
