module "private_fw" {
  source = "github.com/Coalfire-CF/terraform-google-network/modules/firewall-rules"

  project_id   = data.terraform_remote_state.security_core.outputs.networking_project_id
  network_name = module.private.network_name

  rules = [
    # External RDP, SSH & WinRM
    {
      name                    = "${var.firewall_prefix}-private-ext-rdp"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = var.remote_access_cidrs
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["ext-rdp"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["3389"]
      }]
      deny = []
    },
    {
      name                    = "${var.firewall_prefix}-private-ext-ssh"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = var.remote_access_cidrs
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["ext-ssh"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
    },
    {
      name                    = "${var.firewall_prefix}-private-ext-winrm"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = var.remote_access_cidrs
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["ext-winrm"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["5985", "5986"]
      }]
      deny = []
    },
    # Internal RDP, SSH & WinRM
    {
      name                    = "${var.firewall_prefix}-private-int-rdp"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["10.2.0.0/16"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["int-rdp"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["3389"]
      }]
      deny = []
    },
    {
      name                    = "${var.firewall_prefix}-private-int-ssh"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["10.2.0.0/16"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["int-ssh"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
    },
    {
      name                    = "${var.firewall_prefix}-private-int-winrm"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["10.2.0.0/16"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["int-winrm"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["5985", "5986"]
      }]
      deny = []
    }
  ]
}
