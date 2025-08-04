resource "azurerm_virtual_network" "network" {
  name                = var.name
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}
