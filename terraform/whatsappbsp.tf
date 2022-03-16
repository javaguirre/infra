resource "aws_instance" "whatsapp_bsp" {
  ami           = "ami-05b308c240ae70bb6"  # Ubuntu 18.04
  instance_type = "t2.medium"
  key_name      = var.key_name

  ebs_block_device {
    device_name = "/dev/sdg"
    volume_type = "standard"
    volume_size = 30
  }

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id,
  ]

  tags = {
    Name = "whatsapp-bsp"
  }
}

output "whatsapp_bsp" {
  value = "ssh ${aws_instance.whatsapp_bsp.public_ip}:22"
}

resource "aws_db_instance" "bsp_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.9"
  instance_class       = "db.t2.medium"
  name                 = var.bsp_db_name
  username             = var.bsp_db_username
  password             = var.bsp_db_password
  publicly_accessible  = true
}

output "bsp-db" {
  value = "postgres://${aws_db_instance.bsp_db.username}:${aws_db_instance.bsp_db.password}@${aws_db_instance.bsp_db.endpoint}/${aws_db_instance.bsp_db.name}"
}
