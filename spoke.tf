module "resource_group_spoke_1" {
  source   = "./modules/resources"
  name     = var.resource_group_spoke_1_name
  location = var.resource_group_spoke_1_location
}

module "virtual_network_spoke_1" {
  source                  = "./modules/network"
  name                    = var.virtual_network_spoke_1_name
  address_space           = var.virtual_network_spoke_1_address
  resource_group_name     = module.resource_group_spoke_1.name
  resource_group_location = module.resource_group_spoke_1.location
}

module "subnet_spoke_1_aks" {
  source                  = "./modules/subnet"
  name                    = var.subnet_spoke_1_aks_name
  virtual_network_name    = module.virtual_network_spoke_1.name
  resource_group_name     = module.resource_group_spoke_1.name
  resource_group_location = module.resource_group_spoke_1.location
  address_prefixes        = var.subnet_spoke_1_aks_address
}

module "route_table_spoke_1_aks" {
  source                  = "./modules/route"
  name                    = var.route_table_spoke_1_aks_name
  subnet_id               = module.subnet_spoke_1_aks.id
  resource_group_name     = module.resource_group_spoke_1.name
  resource_group_location = module.resource_group_spoke_1.location
}

module "peering_spoke_1_aks_hub" {
  source                    = "./modules/peering"
  name                      = var.peering_spoke_1_aks_hub_name
  resource_group_name       = module.resource_group_spoke_1.name
  virtual_network_name      = module.virtual_network_spoke_1.name
  remote_virtual_network_id = module.virtual_network_hub.id
  allow_forwarded_traffic   = var.peering_spoke_1_aks_hub_traffic
}
