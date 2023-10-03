module "bastion-svc-acct" {
  source = "github.com/Coalfire-CF/ACE-GCP-Service-Account"

  project_id = data.terraform_remote_state.bootstrap.outputs.management_project_id
  prefix     = "sa"
  names      = ["bastion"]
  project_roles = [
    "${data.terraform_remote_state.bootstrap.outputs.management_project_id}=>roles/secretmanager.secretAccessor",
    "${data.terraform_remote_state.bootstrap.outputs.management_project_id}=>roles/source.reader",
    "${data.terraform_remote_state.bootstrap.outputs.management_project_id}=>roles/logging.logWriter",
    "${data.terraform_remote_state.bootstrap.outputs.management_project_id}=>roles/monitoring.metricWriter",
  ]
  display_name = "Bastion"
  description  = "Bastion"
}
