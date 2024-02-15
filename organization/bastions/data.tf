data "google_compute_zones" "available" {
  project = data.terraform_remote_state.security_core.outputs.management_project_id
  region  = var.region
}

data "google_compute_image" "windows_golden" {
  project = "windows-cloud"
  family  = "windows-2019"
}
