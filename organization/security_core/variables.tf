variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "aw_folder_id" {
  description = "Assured Workloads folder ID"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

variable "group_org_admins" {
  description = "Google Group for GCP Organization Administrators"
  type        = string
}

variable "management_services" {
  description = "APIs & Services to enable for management project."
  type        = list(string)
  default = [
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "secretmanager.googleapis.com",
    "sourcerepo.googleapis.com"
  ]
}

variable "networking_services" {
  description = "APIs & Services to enable for networking project."
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "dns.googleapis.com",
    "logging.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

variable "region" {
  description = "The GCP region to create resources in."
  type        = string
  default     = "us-east1"
}
