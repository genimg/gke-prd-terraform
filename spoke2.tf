/* locals {
  spoke2-location       = "eastus2"
  spoke2-resource-group = "spoke2-rg"
}

resource "azurerm_resource_group" "spoke2_rg" {
  name     = local.spoke2-resource-group
  location = local.spoke2-location
}

resource "azurerm_virtual_network" "spoke2_vnet" {
  name                = "spoke2-network"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.spoke2_rg.location
  resource_group_name = azurerm_resource_group.spoke2_rg.name
  #dns_servers         = [azurerm_firewall.fw.ip_configuration[0].private_ip_address]
}

resource "azurerm_virtual_network_peering" "spoke2-to-hub" {
  name                      = "spoke2-to-hub"
  resource_group_name       = azurerm_resource_group.spoke2_rg.name
  virtual_network_name      = azurerm_virtual_network.spoke2_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
}

resource "azurerm_subnet" "vm2_subnet" {
  name                 = "vm2"
  resource_group_name  = azurerm_resource_group.spoke2_rg.name
  virtual_network_name = azurerm_virtual_network.spoke2_vnet.name
  address_prefixes     = ["10.2.2.0/24"]
}

resource "azurerm_route_table" "spoke2_rt" {
  name                = "spoke2_rt"
  location            = azurerm_resource_group.spoke2_rg.location
  resource_group_name = azurerm_resource_group.spoke2_rg.name

  route {
    name                   = "spoke1"
    address_prefix         = azurerm_subnet.vm1_subnet.address_prefixes[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "spoke2_as" {
  subnet_id      = azurerm_subnet.vm2_subnet.id
  route_table_id = azurerm_route_table.spoke2_rt.id
}


resource "azurerm_public_ip" "public_ip_vm2" {
  name                = "vm2_pip"
  resource_group_name = azurerm_resource_group.spoke2_rg.name
  location            = azurerm_resource_group.spoke2_rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vm2_nic" {
  name                = "vm2-nic"
  location            = azurerm_resource_group.spoke2_rg.location
  resource_group_name = azurerm_resource_group.spoke2_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm2_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_vm2.id
  }
}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                            = "example-machine-vm2"
  resource_group_name             = azurerm_resource_group.spoke2_rg.name
  location                        = azurerm_resource_group.spoke2_rg.location
  size                            = "Standard_B1s"
  disable_password_authentication = false
  admin_username                  = "adminuser"
  admin_password                  = "Testpassword12345!"

  network_interface_ids = [
    azurerm_network_interface.vm2_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
} */