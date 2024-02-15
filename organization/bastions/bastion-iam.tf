module "bastion_svc_acct" {
  source = "github.com/Coalfire-CF/terraform-google-service-account"

  project_id = data.terraform_remote_state.security_core.outputs.management_project_id
  prefix     = "sa"
  names      = ["bastion"]
  project_roles = [
    "${data.terraform_remote_state.security_core.outputs.management_project_id}=>roles/secretmanager.secretAccessor",
    "${data.terraform_remote_state.security_core.outputs.management_project_id}=>roles/source.reader",
    "${data.terraform_remote_state.security_core.outputs.management_project_id}=>roles/logging.logWriter",
    "${data.terraform_remote_state.security_core.outputs.management_project_id}=>roles/monitoring.metricWriter",
  ]
  display_name = "Bastion"
  description  = "Bastion"
}
