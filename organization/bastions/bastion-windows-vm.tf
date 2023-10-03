resource "google_compute_address" "windows_ip_address" {
  project = data.terraform_remote_state.bootstrap.outputs.management_project_id
  region  = "us-east1"
  name    = "winbastion-external-ip"
}

module "windows-bastion" {
  source = "github.com/Coalfire-CF/ACE-GCP-VM"

  project_id = data.terraform_remote_state.bootstrap.outputs.management_project_id

  name        = "winbastion"
  domain_name = data.terraform_remote_state.networking.outputs.domain_name

  machine_type = "e2-standard-2"

  source_image        = data.google_compute_image.windows_golden.self_link
  disk_size_gb        = 50
  windows             = true
  disk_encryption_key = data.terraform_remote_state.bootstrap.outputs.gce_kms_key_id

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
    email  = module.bastion-svc-acct.email
    scopes = ["cloud-platform"]
  }

  tags = ["ext-rdp", "ext-winrm", "int-winrm"]
}
