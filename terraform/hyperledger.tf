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
  ]

  tags = {
    Name = "alastria-hyperledger"
  }
}
