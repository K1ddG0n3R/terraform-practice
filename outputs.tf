output "private-ips" {
  value = module.compute.private_ips
}

output "external-ips" {
  value = module.compute.external_ips
}

output "disks" {
  value = module.disks.disk_ids
}

output "ansible_inventory" {
  value = <<EOT
[servers]
${var.environment}-server ansible_host=${module.compute.external_ips.api}
  EOT
}
