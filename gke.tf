module "gke_main" {
  source       = "./modules/gke"

  cluster_name = var.gke_main_cluster_name
  project_id   = var.gcp_project_id
  location     = var.gke_main_location
  network      = var.gke_main_network
  subnetwork   = var.gke_main_subnetwork

  node_pools = var.gke_main_node_pools
  tags       = var.gke_main_tags
}
