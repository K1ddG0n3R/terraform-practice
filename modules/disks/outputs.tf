output "disk_ids" {
  value = { for name, disk in aws_ebs_volume.extra-disks : name => disk.id }
}
