output "linbastion_link" {
  value = module.linux-bastion.instances_details[0].self_link
}

output "winbastion_link" {
  value = module.windows-bastion.instances_details[0].self_link
}
