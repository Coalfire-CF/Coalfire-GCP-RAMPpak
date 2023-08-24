module "cloud_router" {
  source = "github.com/Coalfire-CF/ACE-GCP-Cloud-Router"

  project = data.terraform_remote_state.bootstrap.outputs.networking_project_id
  name    = "${var.router_prefix}-private"
  network = module.private.network_name
  region  = var.region

  nats = [{
    name = "${var.nat_prefix}-private"
  }]
}
