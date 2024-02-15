data "terraform_remote_state" "security_core" {
  backend = "gcs"
  config = {
    bucket = var.state_bucket
    prefix = "terraform/security-core"
  }
}
