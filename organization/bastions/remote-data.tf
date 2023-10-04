data "terraform_remote_state" "security-core" {
  backend = "gcs"
  config = {
    bucket = var.state_bucket
    prefix = "terraform/security-core"
  }
}

data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket = var.state_bucket
    prefix = "terraform/networking"
  }
}
