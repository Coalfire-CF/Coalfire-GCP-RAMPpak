resource "google_sourcerepo_repository" "ansible_code_repository" {
  project = data.terraform_remote_state.bootstrap.outputs.management_project_id
  name    = "ansible"
}
