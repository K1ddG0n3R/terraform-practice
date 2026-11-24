variable "extra_disk_names" {
  description = "Names of extra disk"
  type        = list(string)
  default     = ["logs", "backup"]
}

variable "extra_disk_type" {
  description = "Type of extra disk"
  type        = string
  validation {
    condition = contains(
      ["gp3", "st1"],
      var.extra_disk_type
    )
    error_message = "Choose one of the disk types: gp3 (SSD), st1 (HDD)"
  }
  default = "st1"
}

variable "extra_disk_size" {
  description = "Size of extra disk"
  type        = number
  default     = 20
}

variable "vm-specification" {
  description = "VM configuration: instance type (combinstion vCPU cores & RAM), disk size (GiB), boot-disk (ami-id of boot disk image)"
  type = map(object({
    instance_type = string
    disk_size     = number
    boot_disk     = string
  }))
  validation {
    condition = alltrue([
      for k, v in var.vm-specification : contains(["t4g.small", "t4g.medium"], v.instance_type)
    ])
    error_message = "Acceptable cores/ram option: 2x2, 2x4"
  }
  validation {
    condition = alltrue([
      for k, v in var.vm-specification : v.disk_size > 1
    ])
    error_message = "disk size must be greater than 1 GiB"
  }
  default = {
    "web" = {
      instance_type = "t4g.small"
      disk_size     = 10
      boot_disk     = "ami-04512f58a86d569d1"
    },
    "api" = {
      instance_type = "t4g.small"
      disk_size     = 10
      boot_disk     = "ami-04512f58a86d569d1"
    }
  }
}

variable "ssh-public-key" {
  description = "Public SSH key"
  type        = string
}

variable "environment" {
  description = "Environment type"
  type        = string
}
