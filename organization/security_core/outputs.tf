output "group_org_admins" {
  value = module.security_core.group_org_admins
}

output "management_project_id" {
  value = module.security_core.management_project.project_id
}

output "networking_project_id" {
  value = module.security_core.networking_project.project_id
}

output "gce_kms_key_id" {
  value = module.security_core.kms_keys["compute_engine"]
}

output "gsm_kms_key_id" {
  value = module.security_core.kms_keys["secret_manager"]
}

output "gcs_kms_key_id" {
  value = module.security_core.kms_keys["cloud_storage"]
}

output "sql_kms_key_id" {
  value = module.security_core.kms_keys["cloud_sql"]
}

output "gce_ssh_private_key" {
  value = module.security_core.gce_ssh_private_key
}

output "winbastion_administrator" {
  value = module.security_core.winbastion_administrator
}
