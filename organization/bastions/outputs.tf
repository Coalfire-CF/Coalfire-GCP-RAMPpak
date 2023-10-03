output "linbastion_link" {
  value = module.linux-bastion.instances_details[0].self_link
}

output "winbastion_link" {
  value = module.windows-bastion.instances_details[0].self_link
}

output "ansible_link" {
  value = module.ansible.instances_details[0].self_link
}

output "ansible_private_ip" {
  value = module.ansible.instances_details[0].network_interface[0].network_ip
}

output "ansible_repository_url" {
  value = google_sourcerepo_repository.ansible_code_repository.url
}
