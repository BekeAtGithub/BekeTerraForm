#For managed identities 
resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "adf_identity" {
  principal_id   = azurerm_data_factory.adf.identity.principal_id
  role_definition_name = "Contributor"
  scope          = azurerm_resource_group.rg.id
}
