module "bastion_main" {
  source                      = "./modules/bastion"
  resource_group_location     = module.resource_group_hub.location
  resource_group_name         = module.resource_group_hub.name
  public_ip_name              = var.bastion_main_public_ip_name
  network_interface_name      = var.bastion_main_network_interface_name
  virtual_machine_name        = var.bastion_main_virtual_machine_name
  virtual_machine_size        = var.bastion_main_virtual_machine_size
  network_interface_subnet_id = module.subnet_hub_bastion.id
  ngs_name                    = var.bastion_main_ngs_name
}
