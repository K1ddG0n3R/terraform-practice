output "private-ips" {
  value = module.compute.private_ips
}

output "disks" {
  value = module.disks.disk_ids
}
