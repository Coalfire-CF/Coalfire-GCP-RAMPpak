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

Comment out the GCS backend in `organization/bootstrap/tstate.tf`.

Use the example below, replacing it with your values, and save it as `terraform.tfvars`.

```
org_id           = "your-org-id"
aw_folder_id     = "your-aw-folder-id"
billing_account  = "your-billing-account"
group_org_admins = "grp-gcp-org-admins@your-domain.com"
```

### Run Terraform

Run Terraform init and apply.

```
terraform init
terraform apply -var-file=terraform.tfvars
```

### Migrate local state to remote

Uncomment the GCS backend in `organization/bootstrap/tstate.tf`.

Use the example below, replacing it with your values, and save it as `backend.tfvars`.

```
bucket = "your-state-bucket"
prefix = "terraform/bootstrap"
```

Re-run Terraform init to migrate the state file.

```
terraform init -backend-config=backend.tfvars
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.70.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bootstrap"></a> [bootstrap](#module\_bootstrap) | ../../modules/gcp-bootstrap | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aw_folder_id"></a> [aw\_folder\_id](#input\_aw\_folder\_id) | Assured Workloads folder ID | `string` | n/a | yes |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The ID of the billing account to associate projects with. | `string` | n/a | yes |
| <a name="input_group_org_admins"></a> [group\_org\_admins](#input\_group\_org\_admins) | Google Group for GCP Organization Administrators | `string` | n/a | yes |
| <a name="input_management_services"></a> [management\_services](#input\_management\_services) | APIs & Services to enable for management project. | `list(string)` | <pre>[<br>  "cloudkms.googleapis.com",<br>  "sourcerepo.googleapis.com",<br>  "compute.googleapis.com",<br>  "logging.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "secretmanager.googleapis.com"<br>]</pre> | no |
| <a name="input_networking_services"></a> [networking\_services](#input\_networking\_services) | APIs & Services to enable for networking project. | `list(string)` | <pre>[<br>  "compute.googleapis.com",<br>  "dns.googleapis.com",<br>  "logging.googleapis.com",<br>  "servicenetworking.googleapis.com"<br>]</pre> | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to create resources in. | `string` | `"us-east1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gce-ssh-private-key"></a> [gce-ssh-private-key](#output\_gce-ssh-private-key) | n/a |
| <a name="output_gce_kms_key_id"></a> [gce\_kms\_key\_id](#output\_gce\_kms\_key\_id) | n/a |
| <a name="output_gcs_kms_key_id"></a> [gcs\_kms\_key\_id](#output\_gcs\_kms\_key\_id) | n/a |
| <a name="output_group_org_admins"></a> [group\_org\_admins](#output\_group\_org\_admins) | n/a |
| <a name="output_gsm_kms_key_id"></a> [gsm\_kms\_key\_id](#output\_gsm\_kms\_key\_id) | n/a |
| <a name="output_management_project_id"></a> [management\_project\_id](#output\_management\_project\_id) | n/a |
| <a name="output_networking_project_id"></a> [networking\_project\_id](#output\_networking\_project\_id) | n/a |
| <a name="output_sql_kms_key_id"></a> [sql\_kms\_key\_id](#output\_sql\_kms\_key\_id) | n/a |
| <a name="output_winbastion-administrator"></a> [winbastion-administrator](#output\_winbastion-administrator) | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.70.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security-core"></a> [security-core](#module\_security-core) | github.com/Coalfire-CF/ACE-GCP-Security-Core | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aw_folder_id"></a> [aw\_folder\_id](#input\_aw\_folder\_id) | Assured Workloads folder ID | `string` | n/a | yes |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The ID of the billing account to associate projects with. | `string` | n/a | yes |
| <a name="input_group_org_admins"></a> [group\_org\_admins](#input\_group\_org\_admins) | Google Group for GCP Organization Administrators | `string` | n/a | yes |
| <a name="input_management_services"></a> [management\_services](#input\_management\_services) | APIs & Services to enable for management project. | `list(string)` | <pre>[<br>  "cloudkms.googleapis.com",<br>  "compute.googleapis.com",<br>  "logging.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "pubsub.googleapis.com",<br>  "secretmanager.googleapis.com",<br>  "sourcerepo.googleapis.com"<br>]</pre> | no |
| <a name="input_networking_services"></a> [networking\_services](#input\_networking\_services) | APIs & Services to enable for networking project. | `list(string)` | <pre>[<br>  "compute.googleapis.com",<br>  "dns.googleapis.com",<br>  "logging.googleapis.com",<br>  "servicenetworking.googleapis.com"<br>]</pre> | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to create resources in. | `string` | `"us-east1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gce-ssh-private-key"></a> [gce-ssh-private-key](#output\_gce-ssh-private-key) | n/a |
| <a name="output_gce_kms_key_id"></a> [gce\_kms\_key\_id](#output\_gce\_kms\_key\_id) | n/a |
| <a name="output_gcs_kms_key_id"></a> [gcs\_kms\_key\_id](#output\_gcs\_kms\_key\_id) | n/a |
| <a name="output_group_org_admins"></a> [group\_org\_admins](#output\_group\_org\_admins) | n/a |
| <a name="output_gsm_kms_key_id"></a> [gsm\_kms\_key\_id](#output\_gsm\_kms\_key\_id) | n/a |
| <a name="output_management_project_id"></a> [management\_project\_id](#output\_management\_project\_id) | n/a |
| <a name="output_networking_project_id"></a> [networking\_project\_id](#output\_networking\_project\_id) | n/a |
| <a name="output_sql_kms_key_id"></a> [sql\_kms\_key\_id](#output\_sql\_kms\_key\_id) | n/a |
| <a name="output_winbastion-administrator"></a> [winbastion-administrator](#output\_winbastion-administrator) | n/a |
<!-- END_TF_DOCS -->