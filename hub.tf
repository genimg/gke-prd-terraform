locals {
  hub-location       = "eastus2"
  #hub-resource-group = "p-hub-vnet-rg"
  hub-resource-group = "d-vuelo-hub-rg-eus2-mm4o"
  
}

resource "azurerm_resource_group" "hub-rg" {
  name     = local.hub-resource-group
  location = local.hub-location
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "d-vuelo-vnet-eus2-rt99"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "d-vuelo-snet-eus2-2a3c"
  resource_group_name  = azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.5.0/27"]
}

resource "azurerm_subnet" "apim_subnet" {
  name                 = "d-vuelo-snet-eus2-eb16"
  resource_group_name  = azurerm_resource_group.hub-rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.8.0/24"]
}

resource "azurerm_virtual_network_peering" "hub-to-spoke1" {
  name                      = "d-vuelo-peer-eus2-4d1a"
  resource_group_name       = azurerm_resource_group.hub-rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.p_spoke_aks_mv_vnet.id
  allow_forwarded_traffic   = true
}

/* resource "azurerm_virtual_network_peering" "hub-to-spoke2" {
  name                      = "hub-to-spoke2"
  resource_group_name       = azurerm_resource_group.hub-rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke2_vnet.id
  allow_forwarded_traffic   = true
} */

resource "azurerm_network_security_group" "apim" {
  name                = "d-vuelo-nsg-eus2-ett1"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name

  security_rule {
    name                       = "allowtraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "apimnsgassc" {
  subnet_id                 = azurerm_subnet.apim_subnet.id
  network_security_group_id = azurerm_network_security_group.apim.id
}


####add bastion vm on hub network
resource "azurerm_public_ip" "public_ip_vm1" {
  name                = "d-vuelo-pip-eus2-fg36"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vm1_nic" {
  name                = "d-vuelo-nic-eus2-ed27"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.bastion_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_vm1.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name                            = "d-vuelo-vm-eus2-5tt6"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  size                            = "Standard_B1s"
  disable_password_authentication = false
  admin_username                  = "adminuser"
  admin_password                  = "Piq7Cq5JbKqrCx831E"
  network_interface_ids = [
    azurerm_network_interface.vm1_nic.id,
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
}

resource "azurerm_network_security_group" "bastion" {
  name                = "d-vuelo-nsg-eus2-55t8"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name


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

resource "azurerm_subnet_network_security_group_association" "bastionnsgassc" {
  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}


####apim

resource "azurerm_api_management" "apim" {
  name                = "d-vuelo-apim-eus2-34y6"
  location            = azurerm_resource_group.hub-rg.location
  resource_group_name = azurerm_resource_group.hub-rg.name
  publisher_name      = "Expertia"
  publisher_email     = "company@terraform.io"

  sku_name = "Basic_1"
  #virtual_network_type = "External"
  #virtual_network_configuration {
  #      subnet_id = azurerm_subnet.apim_subnet.id
  #  }
}