resource "google_compute_address" "linux_ip_address" {
  project = data.terraform_remote_state.bootstrap.outputs.management_project_id
  region  = "us-east1"
  name    = "linbastion-external-ip"
}

module "linux-bastion" {
  source = "github.com/Coalfire-CF/ACE-GCP-VM"

  project_id = data.terraform_remote_state.bootstrap.outputs.management_project_id

  name        = "linbastion"
  domain_name = data.terraform_remote_state.networking.outputs.domain_name

  machine_type = "e2-standard-2"

  source_image        = data.google_compute_image.rhel_golden.self_link
  disk_size_gb        = 50
  disk_encryption_key = data.terraform_remote_state.bootstrap.outputs.gce_kms_key_id

  zones      = [data.google_compute_zones.available.names[0]]
  subnetwork = data.terraform_remote_state.networking.outputs.subnets_private["dmz"]

  access_config = [{
    nat_ip       = google_compute_address.linux_ip_address.address
    network_tier = "PREMIUM"
  }]

  labels = {
    osfamily   = "rhel8",
    ostype     = "linux",
    app        = "management",
    patchgroup = "1"
  }

  service_account = {
    email  = module.bastion-svc-acct.email
    scopes = ["cloud-platform"]
  }

  tags = ["ext-ssh"]
}
