terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}

module "disks" {
  source = "./modules/disks"

  environment      = var.environment
  extra_disk_names = var.extra_disk_names
  extra_disk_type  = var.extra_disk_type
  extra_disk_size  = var.extra_disk_size
}

module "compute" {
  source = "./modules/compute"

  environment      = var.environment
  ssh-public-key   = var.ssh-public-key
  vm-specification = var.vm-specification
}

resource "aws_volume_attachment" "attach-extra-disks" {
  for_each = module.disks.disk_ids

  device_name = "/dev/sd${substr(each.key, 0, 1)}"
  instance_id = module.compute.instance_ids.api_instance_id
  volume_id   = each.value
}
