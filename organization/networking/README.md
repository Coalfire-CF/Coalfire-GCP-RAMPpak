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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.70.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.72.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router"></a> [cloud\_router](#module\_cloud\_router) | ../../modules/gcp-cloud-router | n/a |
| <a name="module_management"></a> [management](#module\_management) | ../../modules/gcp-network | n/a |
| <a name="module_private"></a> [private](#module\_private) | ../../modules/gcp-network | n/a |
| <a name="module_private-fw"></a> [private-fw](#module\_private-fw) | ../../modules/gcp-network/modules/firewall-rules | n/a |
| <a name="module_private-management-peering"></a> [private-management-peering](#module\_private-management-peering) | ../../modules/gcp-network/modules/network-peering | n/a |
| <a name="module_private-service-access"></a> [private-service-access](#module\_private-service-access) | ../../modules/gcp-private-service-access | n/a |
| <a name="module_public"></a> [public](#module\_public) | ../../modules/gcp-network | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_subnetwork.private_l7lb](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_subnetwork) | resource |
| [google_compute_shared_vpc_service_project.networking_management](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/compute_shared_vpc_service_project) | resource |
| [google_dns_policy.dns_logging](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/dns_policy) | resource |
| [terraform_remote_state.security-core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | Prefix for DNS. | `string` | `"dns"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Active Directory domain name | `string` | n/a | yes |
| <a name="input_firewall_prefix"></a> [firewall\_prefix](#input\_firewall\_prefix) | Prefix for firewall rules. | `string` | `"fw"` | no |
| <a name="input_ip_network_mgmt"></a> [ip\_network\_mgmt](#input\_ip\_network\_mgmt) | Network part of management CIDR | `string` | `"10.2"` | no |
| <a name="input_nat_prefix"></a> [nat\_prefix](#input\_nat\_prefix) | Prefix for NAT. | `string` | `"nat"` | no |
| <a name="input_peer_prefix"></a> [peer\_prefix](#input\_peer\_prefix) | Prefix for peering. | `string` | `"peer"` | no |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to create resources in. | `string` | `"us-east1"` | no |
| <a name="input_remote_access_cidrs"></a> [remote\_access\_cidrs](#input\_remote\_access\_cidrs) | List of IPv4 CIDR ranges to access all admins remote access | `list(string)` | `[]` | no |
| <a name="input_router_prefix"></a> [router\_prefix](#input\_router\_prefix) | Prefix for router. | `string` | `"cr"` | no |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | Name of the state bucket | `string` | n/a | yes |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | Prefix for subnets. | `string` | `"sb"` | no |
| <a name="input_vpc_prefix"></a> [vpc\_prefix](#input\_vpc\_prefix) | Prefix for VPCs. | `string` | `"vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Active Directory domain name |
| <a name="output_ip_network_mgmt"></a> [ip\_network\_mgmt](#output\_ip\_network\_mgmt) | Network part of management CIDR |
| <a name="output_network_link_management"></a> [network\_link\_management](#output\_network\_link\_management) | Self link of management network |
| <a name="output_network_link_private"></a> [network\_link\_private](#output\_network\_link\_private) | Self link of private network |
| <a name="output_network_link_public"></a> [network\_link\_public](#output\_network\_link\_public) | Self link of public network |
| <a name="output_network_management"></a> [network\_management](#output\_network\_management) | Name of management network |
| <a name="output_network_private"></a> [network\_private](#output\_network\_private) | Name of private network |
| <a name="output_network_public"></a> [network\_public](#output\_network\_public) | Name of public network |
| <a name="output_remote_access_cidrs"></a> [remote\_access\_cidrs](#output\_remote\_access\_cidrs) | List of IPv4 CIDR ranges to access all admins remote access |
| <a name="output_subnets_management"></a> [subnets\_management](#output\_subnets\_management) | Map of management subnet names and IDs |
| <a name="output_subnets_private"></a> [subnets\_private](#output\_subnets\_private) | Map of private subnet names and IDs |
| <a name="output_subnets_public"></a> [subnets\_public](#output\_subnets\_public) | Map of public subnet names and IDs |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.70.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router"></a> [cloud\_router](#module\_cloud\_router) | github.com/Coalfire-CF/ACE-GCP-Cloud-Router | n/a |
| <a name="module_management"></a> [management](#module\_management) | github.com/Coalfire-CF/ACE-GCP-Network | n/a |
| <a name="module_private"></a> [private](#module\_private) | github.com/Coalfire-CF/ACE-GCP-Network | n/a |
| <a name="module_private-fw"></a> [private-fw](#module\_private-fw) | github.com/Coalfire-CF/ACE-GCP-Network/modules/firewall-rules | n/a |
| <a name="module_private-management-peering"></a> [private-management-peering](#module\_private-management-peering) | github.com/Coalfire-CF/ACE-GCP-Network/modules/network-peering | n/a |
| <a name="module_private-service-access"></a> [private-service-access](#module\_private-service-access) | github.com/Coalfire-CF/ACE-GCP-Private-Service-Access | n/a |
| <a name="module_public"></a> [public](#module\_public) | github.com/Coalfire-CF/ACE-GCP-Network | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_subnetwork.private_l7lb](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_subnetwork) | resource |
| [google_compute_shared_vpc_service_project.networking_management](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/compute_shared_vpc_service_project) | resource |
| [google_dns_policy.dns_logging](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/dns_policy) | resource |
| [terraform_remote_state.security-core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | Prefix for DNS. | `string` | `"dns"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name | `string` | n/a | yes |
| <a name="input_firewall_prefix"></a> [firewall\_prefix](#input\_firewall\_prefix) | Prefix for firewall rules. | `string` | `"fw"` | no |
| <a name="input_ip_network_mgmt"></a> [ip\_network\_mgmt](#input\_ip\_network\_mgmt) | Network part of management CIDR | `string` | `"10.2"` | no |
| <a name="input_nat_prefix"></a> [nat\_prefix](#input\_nat\_prefix) | Prefix for NAT. | `string` | `"nat"` | no |
| <a name="input_peer_prefix"></a> [peer\_prefix](#input\_peer\_prefix) | Prefix for peering. | `string` | `"peer"` | no |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to create resources in. | `string` | `"us-east1"` | no |
| <a name="input_remote_access_cidrs"></a> [remote\_access\_cidrs](#input\_remote\_access\_cidrs) | List of IPv4 CIDR ranges to access all admins remote access | `list(string)` | `[]` | no |
| <a name="input_router_prefix"></a> [router\_prefix](#input\_router\_prefix) | Prefix for router. | `string` | `"cr"` | no |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | Name of the state bucket | `string` | n/a | yes |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | Prefix for subnets. | `string` | `"sb"` | no |
| <a name="input_vpc_prefix"></a> [vpc\_prefix](#input\_vpc\_prefix) | Prefix for VPCs. | `string` | `"vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Domain name |
| <a name="output_ip_network_mgmt"></a> [ip\_network\_mgmt](#output\_ip\_network\_mgmt) | Network part of management CIDR |
| <a name="output_network_link_management"></a> [network\_link\_management](#output\_network\_link\_management) | Self link of management network |
| <a name="output_network_link_private"></a> [network\_link\_private](#output\_network\_link\_private) | Self link of private network |
| <a name="output_network_link_public"></a> [network\_link\_public](#output\_network\_link\_public) | Self link of public network |
| <a name="output_network_management"></a> [network\_management](#output\_network\_management) | Name of management network |
| <a name="output_network_private"></a> [network\_private](#output\_network\_private) | Name of private network |
| <a name="output_network_public"></a> [network\_public](#output\_network\_public) | Name of public network |
| <a name="output_remote_access_cidrs"></a> [remote\_access\_cidrs](#output\_remote\_access\_cidrs) | List of IPv4 CIDR ranges to access all admins remote access |
| <a name="output_subnets_management"></a> [subnets\_management](#output\_subnets\_management) | Map of management subnet names and IDs |
| <a name="output_subnets_private"></a> [subnets\_private](#output\_subnets\_private) | Map of private subnet names and IDs |
| <a name="output_subnets_public"></a> [subnets\_public](#output\_subnets\_public) | Map of public subnet names and IDs |
<!-- END_TF_DOCS -->