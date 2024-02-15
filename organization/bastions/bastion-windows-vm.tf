resource "google_compute_address" "windows_ip_address" {
  project = data.terraform_remote_state.security_core.outputs.management_project_id
  region  = var.region
  name    = "winbastion-external-ip"
}

module "windows_bastion" {
  source = "github.com/Coalfire-CF/terraform-google-vm"

  project_id = data.terraform_remote_state.security_core.outputs.management_project_id

  name        = "winbastion"
  domain_name = data.terraform_remote_state.networking.outputs.domain_name

  machine_type = "e2-standard-2"

  source_image        = data.google_compute_image.windows_golden.self_link
  disk_size_gb        = 50
  disk_encryption_key = data.terraform_remote_state.security_core.outputs.gce_kms_key_id

  zones      = [data.google_compute_zones.available.names[0]]
  subnetwork = data.terraform_remote_state.networking.outputs.subnets_private["dmz"]

  access_config = [{
    nat_ip       = google_compute_address.windows_ip_address.address
    network_tier = "PREMIUM"
  }]

  labels = {
    osfamily   = "windows2019",
    ostype     = "windows",
    app        = "management",
    patchgroup = "1"
  }

  service_account = {
    email  = module.bastion_svc_acct.email
    scopes = ["cloud-platform"]
  }

  tags = ["ext-rdp", "ext-winrm", "int-winrm"]
}
