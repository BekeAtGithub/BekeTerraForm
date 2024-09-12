#This file defines outputs for the resources to expose
output "application_gateway_public_ip" {
  value = azurerm_public_ip.example.ip_address
}

output "application_gateway_id" {
  value = azurerm_application_gateway.example.id
}
