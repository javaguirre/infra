output "alastria-hyperledger" {
  value = "ssh ${aws_instance.alastria_hyperledger.public_dns}:22"
}

output "alastria-hyperledger-public-ip" {
  value = "PUBLIC IP: ${aws_eip.alastria_hyperledger_ip.public_ip}"
}

output "prestashop-staging" {
  value = "ssh ${aws_instance.prestashop_staging.public_ip}:22"
}

output "prestashop-production" {
  value = "ssh ${aws_instance.prestashop_production.public_ip}:22"
}

output "proimplant-wordpress" {
  value = "ssh ${aws_instance.proimplant_wordpress.public_ip}:22"
}

output "regular-node-besu-one" {
  value = "ssh ${aws_instance.regular_besu_node_one.public_ip}:22"
}

output "locker-wordpress" {
  value = "A record: ${aws_instance.locker_wordpress.public_dns}"
}
