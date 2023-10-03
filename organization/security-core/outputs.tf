output "group_org_admins" {
  value = module.security-core.group_org_admins
}

output "management_project_id" {
  value = module.security-core.management_project.project_id
}

output "networking_project_id" {
  value = module.security-core.networking_project.project_id
}

output "gce_kms_key_id" {
  value = module.security-core.kms_keys["compute-engine"]
}

output "gsm_kms_key_id" {
  value = module.security-core.kms_keys["secret-manager"]
}

output "gcs_kms_key_id" {
  value = module.security-core.kms_keys["cloud-storage"]
}

output "sql_kms_key_id" {
  value = module.security-core.kms_keys["cloud-sql"]
}

output "gce-ssh-private-key" {
  value = module.security-core.gce-ssh-private-key
}

output "winbastion-administrator" {
  value = module.security-core.winbastion-administrator
}
