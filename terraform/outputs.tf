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
