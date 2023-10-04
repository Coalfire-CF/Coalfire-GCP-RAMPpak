variable "state_bucket" {
  description = "Name of the state bucket"
  type        = string
}

variable "region" {
  description = "The GCP region to create resources in."
  type        = string
  default     = "us-east1"
}
