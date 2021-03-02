resource "aws_instance" "proimplant_wordpress" {
  ami           = "ami-056de12816135f6a1"  # Proimplant WordPress
  instance_type = "t3.medium"
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id
  ]

  ebs_block_device {
    device_name = "/dev/sdg"
    volume_type = "standard"
    volume_size = 80
  }

  tags = {
    Name = "proimplant-wordpress"
  }
}

output "proimplant-wordpress" {
  value = "ssh ${aws_instance.proimplant_wordpress.public_ip}:22"
}
