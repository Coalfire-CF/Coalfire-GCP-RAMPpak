output "winbastion_link" {
  value = module.windows_bastion.instances_details[0].self_link
}
