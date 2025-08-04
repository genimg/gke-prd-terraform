variable "spoke_name" {
  description = "Name identifier for the spoke resources"
  type        = string
}

variable "project_id" {
  description = "GCP project ID where spoke resources will live"
  type        = string
}

variable "region" {
  description = "GCP region for the subnetwork"
  type        = string
}

variable "vpc_self_link" {
  description = "Self-link of the existing hub VPC network"
  type        = string
}

variable "subnet_ip_cidr_range" {
  description = "CIDR range for the spoke subnetwork"
  type        = string
}

variable "peer_vpc_self_link" {
  description = "Self-link of the peer (hub) VPC network to peer with"
  type        = string
}
