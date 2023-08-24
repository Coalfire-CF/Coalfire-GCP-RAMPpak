resource "google_dns_policy" "dns_logging" {
  project = data.terraform_remote_state.bootstrap.outputs.networking_project_id
  name    = "${var.dns_prefix}-logging"

  enable_inbound_forwarding = true
  enable_logging            = true

  networks {
    network_url = module.public.network_self_link
  }
  networks {
    network_url = module.management.network_self_link
  }
  networks {
    network_url = module.private.network_self_link
  }
}
