resource "google_compute_subnetwork" "spoke" {
  name          = "${var.spoke_name}-subnet"
  ip_cidr_range = var.subnet_ip_cidr_range
  region        = var.region
  network       = var.vpc_self_link
  project       = var.project_id
}

# Optional VPC peering with existing hub
resource "google_compute_network_peering" "spoke_to_hub" {
  name         = "${var.spoke_name}-to-hub"
  network      = var.vpc_self_link
  peer_network = var.peer_vpc_self_link
  auto_create_routes = true
}
