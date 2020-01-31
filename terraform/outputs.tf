output "Prestashop URL STAGING" {
  value = "ssh ${aws_instance.prestashop_staging.public_ip}:22"
}

output "Prestashop URL PRODUCTION" {
  value = "ssh ${aws_instance.prestashop_production.public_ip}:22"
}
