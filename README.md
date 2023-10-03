<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

# Coalfire GCP RAMPpak

Coalfire created reference architecture for FedRAMP Google Cloud builds. This repository is used as a parent directory to deploy `Coalfire-CF/terraform-google-<service>` modules.

Learn more at [Coalfire OpenSource](https://coalfire.com/opensource).

## Tooling

- [gcloud CLI](https://cloud.google.com/sdk/gcloud) (435.0.0)
- [Terraform](https://www.terraform.io/downloads) (1.5.0)
- [Terraform Google Cloud Platform Provider Provider](https://registry.terraform.io/providers/hashicorp/google) (4.70.0)

## Dependencies

1. [Setup Cloud Identity](https://cloud.google.com/identity/docs/set-up-cloud-identity-admin) and [verify your domain](https://cloud.google.com/identity/docs/verify-domain).
2. After Cloud Identity has been configured, [create an organization](https://cloud.google.com/resource-manager/docs/creating-managing-organization).
    - Turn on 2-Step Verification enforcement.
3. Create `grp-gcp-org-admins@your-domain.com` group in Cloud Identity and add members.
    - Add **Security** label to group.
    - Select **Restricted** Access type.
4. Create FedRAMP Moderate Assured Workloads folder in [Cloud Console](https://console.cloud.google.com/) on the **Assured Workloads** page. Assured Workloads is required for FedRAMP compliance as Google doesn't have a GovCloud offering.
    - Compliance type: **FedRAMP Moderate**
    - Region: **US**
    - Folder location: **choose organization**
    - Folder name: `fldr-assured-workloads`
    - Review and create folder

## Deployment Order of Operations

1. Dependencies
2. [Security Core](organization/security-core/README.md)
3. [Networking Setup](organization/networking/README.md)
5. [Bastions](organization/bastions/README.md)

## Deployment Configurations

Each folder, e.x. `organization/bootstrap` has a README that provides configuration steps, documents outputs, dependencies, and other notes on each component in the environment.

### Modifications when new Admins are added

- Add new user in [Admin console](https://admin.google.com)
- Add new user as member to `grp-gcp-org-admins@your-domain.com` group

## Environment Setup

- Download and install the gcloud CLI - https://cloud.google.com/sdk/gcloud#download_and_install_the
- Create a new configuration - `gcloud config configurations create <name>`
- Activate the new configuration - `gcloud config configurations activate <name>`
- Authenticate gcloud with new configuration - `gcloud auth application-default login`

## Resources

- [Creating and managing organization resources](https://cloud.google.com/resource-manager/docs/creating-managing-organization#acquiring)
- [Create an Assured Workloads folder](https://cloud.google.com/assured-workloads/docs/create-folder)
- [Google Cloud FedRAMP implementation guide](https://cloud.google.com/architecture/fedramp-implementation-guide)
- [Google Cloud services and authorized regions that are covered by FedRAMP](https://cloud.google.com/security/compliance/fedramp)

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)

## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
