# Networking Setup

The purpose of this module is to deploy the cloud networking components to support the security management and application planes. This module will create:

- Public, management and private networks and subnets
- Firewall rules
- Private service access connection
- Layer 7 load balancing subnet

## Dependencies

- Security Core

## Deployment Steps

### Create .tfvars file

Use the example below, replacing it with your values, and save it as `terraform.tfvars`.

```
state_bucket        = "your-state-bucket"
remote_access_cidrs = ["your-cidr-range"]
domain_name         = "your-domain.com"
```

Use the example below, replacing it with your values, and save it as `backend.tfvars`.

```
bucket = "your-state-bucket"
prefix = "terraform/networking"
```

### Run Terraform

Run Terraform init and apply.

```
terraform init -backend-config=backend.tfvars
terraform apply -var-file=terraform.tfvars
```

