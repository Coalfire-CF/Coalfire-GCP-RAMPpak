# Security Core

The purpose of this module is to help bootstrap a GCP organization, creating all the required GCP resources to start deploying the FedRAMP reference architecture. The bootstrap is a dependency for all other deployment components. This module will create:

- Folders and Projects under the Assured Workloads folder
- Activate required APIs & Services in projects
- Create customer-managed encryption keys
- Create cloud storage buckets for Terraform state, installs and backups
- Create an organization log sink and destination
- Configure organization policies
- Enable audit logging

## Dependencies

- Google Cloud organization
- Assured Workloads folder

## Deployment Steps

### Create .tfvars file

Comment out the GCS backend in `organization/security-core/tstate.tf`.

Use the example below, replacing it with your values, and save it as `terraform.tfvars`.

```
org_id           = "your-org-id"
aw_folder_id     = "your-aw-folder-id"
billing_account  = "your-billing-account"
group_org_admins = "grp-gcp-org-admins@your-domain.com"
workspace_id     = "your-workspace-id"
region           = "your-gcp-region"
```

### Run Terraform

Run Terraform init and apply.

```
terraform init
terraform apply -var-file=terraform.tfvars
```

### Migrate local state to remote

Uncomment the GCS backend in `organization/security-core/tstate.tf`.

Use the example below, replacing it with your values, and save it as `backend.tfvars`.

```
bucket = "your-state-bucket"
prefix = "terraform/security-core"
```

Re-run Terraform init to migrate the state file.

```
terraform init -backend-config=backend.tfvars
```

