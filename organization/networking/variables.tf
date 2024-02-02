variable "state_bucket" {
  description = "Name of the state bucket"
  type        = string
}

variable "region" {
  description = "The GCP region to create resources in."
  type        = string
  default     = "us-east1"
}

variable "ip_network_public" {
  description = "Network part of public CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ip_network_management" {
  description = "Network part of management CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "ip_network_private" {
  description = "Network part of private CIDR"
  type        = string
  default     = "10.2.0.0/16"
}

variable "remote_access_cidrs" {
  description = "List of IPv4 CIDR ranges to access all admins remote access"
  type        = list(string)
  default     = []
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "dns_prefix" {
  description = "Prefix for DNS."
  type        = string
  default     = "dns"
}

variable "vpc_prefix" {
  description = "Prefix for VPCs."
  type        = string
  default     = "vpc"
}

variable "subnet_prefix" {
  description = "Prefix for subnets."
  type        = string
  default     = "sb"
}

variable "firewall_prefix" {
  description = "Prefix for firewall rules."
  type        = string
  default     = "fw"
}

variable "router_prefix" {
  description = "Prefix for router."
  type        = string
  default     = "cr"
}

variable "nat_prefix" {
  description = "Prefix for NAT."
  type        = string
  default     = "nat"
}

variable "peer_prefix" {
  description = "Prefix for peering."
  type        = string
  default     = "peer"
}
