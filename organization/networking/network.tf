module "public" {
  source = "github.com/Coalfire-CF/terraform-google-network"

  project_id   = data.terraform_remote_state.security_core.outputs.networking_project_id
  network_name = "${var.vpc_prefix}-public"

  subnets = [
    {
      subnet_name   = "${var.subnet_prefix}-public-firewall"
      subnet_ip     = module.subnets_public.network_cidr_blocks["firewall"]
      subnet_region = var.region
    }
  ]
}

module "management" {
  source = "github.com/Coalfire-CF/terraform-google-network"

  project_id      = data.terraform_remote_state.security_core.outputs.networking_project_id
  network_name    = "${var.vpc_prefix}-management"
  shared_vpc_host = true

  subnets = [
    {
      subnet_name   = "${var.subnet_prefix}-management-firewall"
      subnet_ip     = module.subnets_management.network_cidr_blocks["firewall"]
      subnet_region = var.region
    }
  ]
}

module "private" {
  source = "github.com/Coalfire-CF/terraform-google-network"

  project_id   = data.terraform_remote_state.security_core.outputs.networking_project_id
  network_name = "${var.vpc_prefix}-private"

  subnets = [
    {
      subnet_name   = "${var.subnet_prefix}-private-firewall"
      subnet_ip     = module.subnets_private.network_cidr_blocks["firewall"]
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-iam"
      subnet_ip     = module.subnets_private.network_cidr_blocks["iam"]
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-cicd"
      subnet_ip     = module.subnets_private.network_cidr_blocks["cicd"]
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-secops"
      subnet_ip     = module.subnets_private.network_cidr_blocks["secops"]
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-siem"
      subnet_ip     = module.subnets_private.network_cidr_blocks["siem"]
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-monitoring"
      subnet_ip     = module.subnets_private.network_cidr_blocks["monitoring"]
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-dmz"
      subnet_ip     = module.subnets_private.network_cidr_blocks["dmz"]
      subnet_region = var.region
    }
  ]
}

module "private_management_peering" {
  source = "github.com/Coalfire-CF/terraform-google-network/modules/network-peering"

  prefix        = "${var.peer_prefix}-${module.private.network_name}-${module.management.network_name}"
  local_network = module.private.network_self_link
  peer_network  = module.management.network_self_link
}

module "private_service_access" {
  source = "github.com/Coalfire-CF/ACE-GCP-Private-Service-Access"

  project_id = data.terraform_remote_state.security_core.outputs.networking_project_id

  network       = module.private.network_name
  name          = "${var.subnet_prefix}-private-psa"
  peering_range = module.subnets_private.network_cidr_blocks["psa"]

  depends_on = [module.private]
}

resource "google_compute_subnetwork" "private_l7lb" {
  provider = google-beta

  project       = data.terraform_remote_state.security_core.outputs.networking_project_id
  region        = var.region
  name          = "${var.subnet_prefix}-private-proxy"
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
  ip_cidr_range = module.subnets_private.network_cidr_blocks["proxy"]
  network       = module.private.network_id
}

resource "google_compute_shared_vpc_service_project" "networking_management" {
  host_project    = data.terraform_remote_state.security_core.outputs.networking_project_id
  service_project = data.terraform_remote_state.security_core.outputs.management_project_id
}
