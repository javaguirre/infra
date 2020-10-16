resource "aws_eip" "alastria_hyperledger_ip" {
  instance = aws_instance.alastria_hyperledger.id
  vpc      = true
}

resource "aws_instance" "alastria_hyperledger" {
  ami           = "ami-00caf1798495a2300"
  instance_type = "t2.large"
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.egress-tls.id,
    aws_security_group.hyperledger_node.id,
  ]

  ebs_block_device {
    device_name = "/dev/sdg"
    volume_type = "standard"
    volume_size = 100
  }

  tags = {
    Name = "alastria-hyperledger"
  }
}


resource "aws_security_group" "hyperledger_node" {
  name        = "hyperledger node"
  description = ""

  ingress {
    from_port   = 7051
    to_port     = 7051
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 7077
    to_port     = 7077
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
