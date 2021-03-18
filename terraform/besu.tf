resource "aws_eip" "regular_besu_node_one" {
  instance = aws_instance.regular_besu_node_one.id
  vpc      = true
}

resource "aws_instance" "regular_besu_node_one" {
  ami           = "ami-0d359437d1756caa8"  # Ubuntu 18.04
  instance_type = var.ec2_size
  key_name      = var.prestashop_key_name

  vpc_security_group_ids = [
    aws_security_group.web.id,
    aws_security_group.ssh.id,
    aws_security_group.besu.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "regular-besu-one"
  }
}

resource "aws_security_group" "besu" {
  name        = "default-besu-ports"
  description = "Security group for besu"

  ingress {
    from_port   = 30303
    to_port     = 30303
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8545
    to_port     = 8545
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "regular-node-besu-one" {
  value = "ssh ${aws_instance.regular_besu_node_one.public_ip}:22"
}

output "regular-node-besu-one-eip" {
  value = "PUBLIC IP: ${aws_eip.regular_besu_node_one.public_ip}"
}
