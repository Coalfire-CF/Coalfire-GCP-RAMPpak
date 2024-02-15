terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.70.0"
    }
  }
  # backend "gcs" {
  #   # Specify bucket & prefix in backend.tfvars
  # }
}
