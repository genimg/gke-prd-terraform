module "resource_group_hub" {
  source   = "./modules/resources"
  name     = var.resource_group_hub_name
  location = var.resource_group_hub_location
}

module "virtual_network_hub" {
  source                  = "./modules/network"
  name                    = var.virtual_network_hub_name
  address_space           = var.virtual_network_hub_address
  resource_group_name     = module.resource_group_hub.name
  resource_group_location = module.resource_group_hub.location
}

module "subnet_hub_bastion" {
  source                  = "./modules/subnet"
  name                    = var.subnet_hub_bastion_name
  virtual_network_name    = module.virtual_network_hub.name
  resource_group_name     = module.resource_group_hub.name
  resource_group_location = module.resource_group_hub.location
  address_prefixes        = var.subnet_hub_bastion_address
}

module "peering_hub_to_spoke_1" {
  source                    = "./modules/peering"
  name                      = var.peering_hub_to_spoke_1_name
  resource_group_name       = module.resource_group_hub.name
  virtual_network_name      = module.virtual_network_hub.name
  remote_virtual_network_id = module.virtual_network_spoke_1.id
  allow_forwarded_traffic   = var.peering_hub_to_spoke_1_traffic
}
