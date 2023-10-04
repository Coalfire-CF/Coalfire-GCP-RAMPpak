output "winbastion_link" {
  value = module.windows-bastion.instances_details[0].self_link
}
