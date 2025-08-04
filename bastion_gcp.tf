module "bastion_main_gcp" {
  source      = "./modules/bastion_gcp"

  instance_name = var.bastion_gcp_instance_name
  zone          = var.bastion_gcp_zone
  machine_type  = var.bastion_gcp_machine_type
  network       = var.bastion_gcp_network
  subnetwork    = var.bastion_gcp_subnetwork
  disk_size_gb  = var.bastion_gcp_disk_size_gb
  tags          = var.bastion_gcp_tags
}
