# Terraform AWS VM Infrastructure

This project provisions a simple infrastructure in **AWS** using **Terraform**.  
It creates two virtual machines (`api` and `web`) with configurable resources and attaches additional data disks to the API VM.
___
## 📦 What This Project Creates

- 2 Virtual Machines:
    - **API VM**
    - **WEB VM**
- Boot disks created from a specified OS image
- Additional data disks (`logs`, `backup`) attached to the API VM
- SSH access using a local public key
___
## 📁 Project Structure
```
.
├── main.tf
├── modules
│   ├── compute # Compute instances, vpc, subnet data source
│   │   ├── main.tf
│   │   ├── networks.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── disks # Extra disks
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf # Output disk ids, private/external ips
├── variables.tf # Input variables and validation rules
├── terraform.tfstate
└── README.md
```
___
## 🔧 Providers
The project uses the official AWS Terraform provider:
```
hashicorp/aws
```
___
## 🌍 Default Configuration

### Zone

- `us-east-1`

### Virtual Machines

| VM  | Instance Type (Cores/Memory) | Boot Disk (GB) |
| --- | ---------------------------- | -------------- |
| api | t4g.small (2/4)              | 10             |
| web | t4g.small (2/4)              | 10             |

### Extra Disks (API VM only)

| Name   | Size (GB) | Type      |
| ------ | --------- | --------- |
| logs   | 20        | st1 (HDD) |
| backup | 20        | st1 (HDD) |
___
## 🔐 SSH Access

SSH access is configured using the local public key:

```
~/.ssh/id_ed25519.pub
```
Username: `ubuntu`
___
## 🧠 Variables Overview

Key input variables:

- `extra_disk_names` - List of names for extra disks
- `extra_disk_type` - Type of extra disk
- `extra_disk_size` - Size of extra disk
### VM Specification Validation

The configuration enforces:

- Exactly **2 CPU cores**
- **2 or 4 GB RAM**
- Boot disk size **>= 1 GB**
___
## 🚀 How to Use

### Initialize Terraform

```
terraform init
```

### Plan apply for dev environment

```
terraform plan -var-file=terraform.tfvars.dev

terraform apply -var-file=terraform.tfvars.dev
```

### Plan apply for prod environment

```
terraform plan -var-file=terraform.tfvars.prod

terraform apply -var-file=terraform.tfvars.prod
```
___
## 🧹 Cleanup

To destroy all created resources:

```
terraform destroy
```