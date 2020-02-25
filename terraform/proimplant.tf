resource "aws_instance" "proimplant_wordpress" {
  ami           = "ami-06206646e9f976074"  # WordPress from Bitnami
  instance_type = var.ec2_size
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "proimplant-wordpress"
  }
}
