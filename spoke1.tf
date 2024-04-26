locals {
  spoke1-location       = "eastus2"
  spoke1-resource-group = "d-vuelo-spoke-rg-eus2-mw4o"
}

resource "azurerm_resource_group" "p_spoke_aks_mv_rg" {
  name     = local.spoke1-resource-group
  location = local.spoke1-location
}

resource "azurerm_virtual_network" "p_spoke_aks_mv_vnet" {
  name                = "d-vuelo-vnet-eus2-2t19"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.p_spoke_aks_mv_rg.location
  resource_group_name = azurerm_resource_group.p_spoke_aks_mv_rg.name
  #dns_servers         = [azurerm_firewall.fw.ip_configuration[0].private_ip_address]
}

resource "azurerm_virtual_network_peering" "spoke-aks-mv-to-hub" {
  name                      = "d-vuelo-peer-eus2-1ce3"
  resource_group_name       = azurerm_resource_group.p_spoke_aks_mv_rg.name
  virtual_network_name      = azurerm_virtual_network.p_spoke_aks_mv_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
}

resource "azurerm_subnet" "p_aks_mv_subnet" {
  name                 = "d-vuelo-snet-eus2-ab56"
  resource_group_name  = azurerm_resource_group.p_spoke_aks_mv_rg.name
  virtual_network_name = azurerm_virtual_network.p_spoke_aks_mv_vnet.name
  address_prefixes     = ["10.1.0.0/22"]
}

resource "azurerm_subnet" "application_gateway_subnet" {
  name                 = "d-vuelo-agw-eus2-88t1"
  resource_group_name  = azurerm_resource_group.p_spoke_aks_mv_rg.name
  virtual_network_name = azurerm_virtual_network.p_spoke_aks_mv_vnet.name
  address_prefixes     = ["10.1.5.0/27"]
}

resource "azurerm_network_security_group" "appgw" {
  name                = "d-vuelo-nsg-eus2-evt1"
  location            = azurerm_resource_group.p_spoke_aks_mv_rg.location
  resource_group_name = azurerm_resource_group.p_spoke_aks_mv_rg.name

####esta regla se crea por limitante del sku del appgw
  security_rule {
    name                       = "allowappgwskutraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range         = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
####esta regla se crea porque son los rangos de salida del apim
  security_rule {
    name                       = "allowapimtraffic"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes      = ["4.152.229.224"] #apim ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "blocktraffic"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "appgwnsgassc" {
  subnet_id                 = azurerm_subnet.application_gateway_subnet.id
  network_security_group_id = azurerm_network_security_group.appgw.id
}

 resource "azurerm_route_table" "spoke_aks_mv_rt" {
   name                = "d-vuelo-rt-eus2-e8ju"
   location            = azurerm_resource_group.p_spoke_aks_mv_rg.location
   resource_group_name = azurerm_resource_group.p_spoke_aks_mv_rg.name

 }

#resource "azurerm_route_table" "spoke_aks_mv_rt2" {
#  name                = "spoke_aks_mv_rt2"
#  location            = azurerm_resource_group.p_spoke_aks_mv_rg.location
#  resource_group_name = azurerm_resource_group.p_spoke_aks_mv_rg.name
  


#  route {
#    name                   = "hub"
#    address_prefix         = "${azurerm_firewall.fw.ip_configuration[0].private_ip_address}/32"
#    next_hop_type          = "VirtualAppliance"
#    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
#  }
#}

resource "azurerm_subnet_route_table_association" "spoke_aks_mv_as" {
  subnet_id      = azurerm_subnet.p_aks_mv_subnet.id
  route_table_id = azurerm_route_table.spoke_aks_mv_rt.id
}


