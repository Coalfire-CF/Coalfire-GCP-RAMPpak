output "domain_name" {
  description = "Domain name"
  value       = var.domain_name
}

output "remote_access_cidrs" {
  description = "List of IPv4 CIDR ranges to access all admins remote access"
  value       = var.remote_access_cidrs
}

output "ip_network_public" {
  description = "Network part of public CIDR"
  value       = var.ip_network_public
}

output "ip_network_management" {
  description = "Network part of management CIDR"
  value       = var.ip_network_management
}

output "ip_network_private" {
  description = "Network part of private CIDR"
  value       = var.ip_network_private
}

output "subnets_public" {
  description = "Map of public subnet names and IDs"
  value       = zipmap([for name in module.public.subnets_names : replace(name, "${var.subnet_prefix}-public-", "")], module.public.subnets_ids)
}

output "subnets_public_cidr" {
  description = "Map of public subnet names and CIDRs"
  value       = zipmap([for name in module.public.subnets_names : replace(name, "${var.subnet_prefix}-public-", "")], module.public.subnets_ips)
}

output "subnets_management" {
  description = "Map of management subnet names and IDs"
  value       = zipmap([for name in module.management.subnets_names : replace(name, "${var.subnet_prefix}-management-", "")], module.management.subnets_ids)
}

output "subnets_management_cidr" {
  description = "Map of management subnet names and CIDRs"
  value       = zipmap([for name in module.management.subnets_names : replace(name, "${var.subnet_prefix}-management-", "")], module.management.subnets_ips)
}

output "subnets_private" {
  description = "Map of private subnet names and IDs"
  value       = zipmap([for name in module.private.subnets_names : replace(name, "${var.subnet_prefix}-private-", "")], module.private.subnets_ids)
}

output "subnets_private_cidr" {
  description = "Map of private subnet names and CIDRs"
  value       = zipmap([for name in module.private.subnets_names : replace(name, "${var.subnet_prefix}-private-", "")], module.private.subnets_ips)
}

output "network_public" {
  description = "Name of public network"
  value       = module.public.network_name
}

output "network_management" {
  description = "Name of management network"
  value       = module.management.network_name
}

output "network_private" {
  description = "Name of private network"
  value       = module.private.network_name
}

output "network_link_public" {
  description = "Self link of public network"
  value       = module.public.network_self_link
}

output "network_link_management" {
  description = "Self link of management network"
  value       = module.management.network_self_link
}

output "network_link_private" {
  description = "Self link of private network"
  value       = module.private.network_self_link
}
