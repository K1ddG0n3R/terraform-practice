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

variable "environment" {
  description = "Environment type"
  type        = string
  validation {
    condition     = contains(["dev", "prod"])
    error_message = "Choose 'dev' or 'prod' environment"
  }
}
