output "public_ip" {
  value = azurerm_api_management.api_management.public_ip_addresses
}