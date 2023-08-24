data "google_compute_zones" "available" {
  project = data.terraform_remote_state.bootstrap.outputs.management_project_id
  region  = var.region
}

data "google_compute_image" "rhel_golden" {
  project = data.terraform_remote_state.bootstrap.outputs.management_project_id
  family  = "rhel-8-golden"
}

data "google_compute_image" "windows_golden" {
  project = data.terraform_remote_state.bootstrap.outputs.management_project_id
  family  = "windows-2019-golden"
}
