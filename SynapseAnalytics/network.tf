
# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet for Azure Synapse Managed Private Endpoint
resource "azurerm_subnet" "synapse_subnet" {
  name                 = var.synapse_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

# Private Link Endpoint for Synapse
resource "azurerm_private_link_service" "synapse_private_link" {
  name                = "synapse-private-link"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  virtual_network_id  = azurerm_virtual_network.vnet.id
}
