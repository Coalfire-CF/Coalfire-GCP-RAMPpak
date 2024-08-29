module "cloud_router" {
  source = "github.com/Coalfire-CF/terraform-google-cloud-router"

  project = data.terraform_remote_state.security_core.outputs.networking_project_id
  name    = "${var.router_prefix}-private"
  network = module.private.network_name
  region  = var.region

  nats = [{
    name                                = "${var.nat_prefix}-private"
    enable_dynamic_port_allocation      = true
    enable_endpoint_independent_mapping = false
  }]
}
