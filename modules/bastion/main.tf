resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "random_password" "password" {
  length  = 16
  special = false
  # override_special = "!@#$%&*()-=+[]{}<>?"
  # min_lower = 1
  # min_upper = 1
  # min_numeric = 1
  # min_special = 1
}

resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.network_interface_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name                            = var.virtual_machine_name
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  size                            = var.virtual_machine_size
  disable_password_authentication = false
  admin_username                  = local.bastion_user_name
  admin_password                  = random_password.password.result
  network_interface_ids = [
    azurerm_network_interface.nic.id,
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
  name                = var.ngs_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  lifecycle {
    ignore_changes = [
      security_rule,
    ]
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

resource "azurerm_subnet_network_security_group_association" "bastionnsgassc" {
  subnet_id                 = var.network_interface_subnet_id
  network_security_group_id = azurerm_network_security_group.bastion.id
}
