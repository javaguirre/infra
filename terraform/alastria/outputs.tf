output "alastria-bootnode" {
  value = "ssh ${aws_instance.alastria_bootnode.public_ip}:22"
}
