module "public" {
  source = "github.com/Coalfire-CF/ACE-GCP-Network"

  project_id   = data.terraform_remote_state.bootstrap.outputs.networking_project_id
  network_name = "${var.vpc_prefix}-public"

  subnets = [
    {
      subnet_name   = "${var.subnet_prefix}-public-firewall"
      subnet_ip     = "10.0.0.0/23"
      subnet_region = var.region
    }
  ]
}

module "management" {
  source = "github.com/Coalfire-CF/ACE-GCP-Network"

  project_id      = data.terraform_remote_state.bootstrap.outputs.networking_project_id
  network_name    = "${var.vpc_prefix}-management"
  shared_vpc_host = true

  subnets = [
    {
      subnet_name   = "${var.subnet_prefix}-management-firewall"
      subnet_ip     = "10.1.0.0/23"
      subnet_region = var.region
    }
  ]
}

module "private" {
  source = "github.com/Coalfire-CF/ACE-GCP-Network"

  project_id   = data.terraform_remote_state.bootstrap.outputs.networking_project_id
  network_name = "${var.vpc_prefix}-private"

  subnets = [
    {
      subnet_name   = "${var.subnet_prefix}-private-firewall"
      subnet_ip     = "${var.ip_network_mgmt}.0.0/23"
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-iam"
      subnet_ip     = "${var.ip_network_mgmt}.2.0/23"
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-cicd"
      subnet_ip     = "${var.ip_network_mgmt}.4.0/23"
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-secops"
      subnet_ip     = "${var.ip_network_mgmt}.6.0/23"
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-siem"
      subnet_ip     = "${var.ip_network_mgmt}.8.0/23"
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-monitoring"
      subnet_ip     = "${var.ip_network_mgmt}.10.0/23"
      subnet_region = var.region
    },
    {
      subnet_name   = "${var.subnet_prefix}-private-dmz"
      subnet_ip     = "${var.ip_network_mgmt}.100.0/23"
      subnet_region = var.region
    }
  ]
}

module "private-management-peering" {
  source = "github.com/Coalfire-CF/ACE-GCP-Network/modules/network-peering"

  prefix        = "${var.peer_prefix}-${module.private.network_name}-${module.management.network_name}"
  local_network = module.private.network_self_link
  peer_network  = module.management.network_self_link
}

module "private-service-access" {
  source = "github.com/Coalfire-CF/ACE-GCP-Private-Service-Access"

  project_id = data.terraform_remote_state.bootstrap.outputs.networking_project_id

  network       = module.private.network_name
  name          = "${var.subnet_prefix}-private-psa"
  peering_range = "${var.ip_network_mgmt}.12.0/23"

  depends_on = [module.private]
}

resource "google_compute_subnetwork" "private_l7lb" {
  provider = google-beta

  project       = data.terraform_remote_state.bootstrap.outputs.networking_project_id
  region        = var.region
  name          = "${var.subnet_prefix}-private-proxy"
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
  ip_cidr_range = "${var.ip_network_mgmt}.14.0/23"
  network       = module.private.network_id
}

resource "google_compute_shared_vpc_service_project" "networking_management" {
  host_project    = data.terraform_remote_state.bootstrap.outputs.networking_project_id
  service_project = data.terraform_remote_state.bootstrap.outputs.management_project_id
}
