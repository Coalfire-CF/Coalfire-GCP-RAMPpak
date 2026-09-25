# Setup Bastions

The purpose of this module is to deploy bastions. This module will create:

- Bastion to establish a session into the environment

## Dependencies

- Networking

## Deployment Steps

### Create .tfvars file

Use the example below, replacing it with your values, and save it as `terraform.tfvars`.

``` hcl
state_bucket        = "your-state-bucket"
```

Use the example below, replacing it with your values, and save it as `backend.tfvars`.

``` hcl
bucket = "your-state-bucket"
prefix = "terraform/bastions"
```

### Run Terraform

Run Terraform init and apply.

``` hcl
terraform init -backend-config=backend.tfvars
terraform apply -var-file=terraform.tfvars
```

