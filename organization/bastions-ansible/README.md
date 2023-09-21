# Setup Bastions and Ansible

The purpose of this module is to deploy bastions and a Linux host with Ansible-cli (core) installed. This module will create:

- Cloud Source Repository to store Ansible code
- Windows bastion to establish an RDP session into the environment
- Linux bastion primarily to serve as an SSH forwarder to the Ansible CLI host
- Linux instance with Ansible + Collections installed to configure the internal environment

## Dependencies

- Packer Images
- Add **Cloud Source Repositories** exception in **Organization Policies**
  - In the Cloud Console, navigate to **Organization Policies** for management project
  - Edit **Restrict Resource Service Usage** `constraints/gcp.restrictServiceUsage` policy
  - Select **Merge with parent** for **Policy enforcement**
  - Add a new rule
  - Select **Custom** for **Policy values**
  - Select **Allow** for **Policy type**
  - Add **Custom value** of `sourcerepo.googleapis.com`

## Deployment Steps

### Create .tfvars file

Use the example below, replacing it with your values, and save it as `terraform.tfvars`.

``` hcl
state_bucket        = "your-state-bucket"
```

Use the example below, replacing it with your values, and save it as `backend.tfvars`.

``` hcl
bucket = "your-state-bucket"
prefix = "terraform/bastions-ansible"
```

### Run Terraform

Run Terraform init and apply.

``` hcl
terraform init -backend-config=backend.tfvars
terraform apply -var-file=terraform.tfvars
```

### Configuration

1. Open the **ansible** [Cloud Source Repositories](https://source.cloud.google.com/) repository in a web browser.
2. On the **Add code to your repository** screen, choose **Manually generate credentials** and follow the link to **Generate and store your Git credentials**.
3. Push the Ansible playbooks into the **ansible** Cloud Source Repositories repository.
4. Open **Compute Engine** in the [Cloud Console](https://console.cloud.google.com/) and set the Windows password for **administrator** user on **winbastion** instance and add to `winbastion-administrator` secret in Secret Manager.

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
| [terraform_remote_state.bootstrap](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
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
