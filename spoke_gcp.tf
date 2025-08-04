module "spoke_gcp" {
  source = "./modules/vpc_spoke_gcp"

  spoke_name            = var.spoke_name
  project_id            = var.gcp_project_id
  region                = var.spoke_region
  vpc_self_link         = var.spoke_vpc_self_link
  subnet_ip_cidr_range  = var.spoke_subnet_cidr
  peer_vpc_self_link    = var.spoke_peer_vpc_self_link
}
