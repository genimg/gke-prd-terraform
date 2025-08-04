resource "azurerm_route_table" "table" {
   name                = var.name
   location            = var.resource_group_location
   resource_group_name = var.resource_group_name

 }

resource "azurerm_subnet_route_table_association" "association" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.table.id
}

