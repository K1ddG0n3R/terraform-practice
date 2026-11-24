resource "aws_ebs_volume" "extra-disks" {
  for_each          = toset(var.extra_disk_names)
  availability_zone = "us-east-1a"
  size              = var.extra_disk_size
  type              = var.extra_disk_type

  tags = {
    Name = "${var.environment}-${each.key}-storage"
  }
}
