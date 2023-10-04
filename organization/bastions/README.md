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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.70.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ansible"></a> [ansible](#module\_ansible) | ../../modules/gcp-vm | n/a |
| <a name="module_ansible-svc-acct"></a> [ansible-svc-acct](#module\_ansible-svc-acct) | ../../modules/gcp-service-accounts | n/a |
| <a name="module_bastion-svc-acct"></a> [bastion-svc-acct](#module\_bastion-svc-acct) | ../../modules/gcp-service-accounts | n/a |
| <a name="module_linux-bastion"></a> [linux-bastion](#module\_linux-bastion) | ../../modules/gcp-vm | n/a |
| <a name="module_windows-bastion"></a> [windows-bastion](#module\_windows-bastion) | ../../modules/gcp-vm | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.linux_ip_address](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/compute_address) | resource |
| [google_compute_address.windows_ip_address](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/compute_address) | resource |
| [google_sourcerepo_repository.ansible_code_repository](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/sourcerepo_repository) | resource |
| [google_compute_image.rhel_golden](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/data-sources/compute_image) | data source |
| [google_compute_image.windows_golden](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/data-sources/compute_image) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/data-sources/compute_zones) | data source |
| [terraform_remote_state.security-core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The GCP region to create resources in. | `string` | `"us-east1"` | no |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | Name of the state bucket | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ansible_link"></a> [ansible\_link](#output\_ansible\_link) | n/a |
| <a name="output_ansible_private_ip"></a> [ansible\_private\_ip](#output\_ansible\_private\_ip) | n/a |
| <a name="output_ansible_repository_url"></a> [ansible\_repository\_url](#output\_ansible\_repository\_url) | n/a |
| <a name="output_linbastion_link"></a> [linbastion\_link](#output\_linbastion\_link) | n/a |
| <a name="output_winbastion_link"></a> [winbastion\_link](#output\_winbastion\_link) | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.70.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion-svc-acct"></a> [bastion-svc-acct](#module\_bastion-svc-acct) | github.com/Coalfire-CF/terraform-google-service-account | n/a |
| <a name="module_windows-bastion"></a> [windows-bastion](#module\_windows-bastion) | github.com/Coalfire-CF/terraform-google-vm | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_address.windows_ip_address](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/compute_address) | resource |
| [google_compute_image.windows_golden](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/data-sources/compute_image) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/data-sources/compute_zones) | data source |
| [terraform_remote_state.networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.security-core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | The GCP region to create resources in. | `string` | `"us-east1"` | no |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | Name of the state bucket | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_winbastion_link"></a> [winbastion\_link](#output\_winbastion\_link) | n/a |
<!-- END_TF_DOCS -->