resource "aws_instance" "alastria_bootnode" {
  ami           = var.alastria_ami
  instance_type = var.alastria_instance_size
  key_name      = var.alastria_key_name

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.alastria-node-ports.id
  ]

  tags = {
    Name = "alastria-bootnode"
  }
}
