module "security_core" {
  source = "github.com/Coalfire-CF/terraform-google-security-core"

  org_id           = var.org_id
  aw_folder_id     = var.aw_folder_id
  billing_account  = var.billing_account
  group_org_admins = var.group_org_admins

  management_services = var.management_services
  networking_services = var.networking_services

  region = var.region
}
