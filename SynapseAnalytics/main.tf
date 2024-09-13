#
provider "azurerm" {
  features {}
}

# Resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Synapse Workspace
resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.synapse_workspace_name
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.synapse_storage.id
  sql_administrator_login              = var.sql_administrator_login
  sql_administrator_login_password     = var.sql_administrator_password
}

# Synapse SQL pool (optional)
resource "azurerm_synapse_sql_pool" "synapse_sql_pool" {
  name                 = var.sql_pool_name
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku {
    name     = "DW100c"
    capacity = 100
  }
}

# Synapse Firewall Rule
resource "azurerm_synapse_firewall_rule" "firewall_rule" {
  name                 = "AllowAllAzureIPs"
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"
}

# Data Lake Storage (required for Synapse)
resource "azurerm_storage_account" "synapse_storage" {
  name                     = var.storage_account_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  is_hns_enabled            = true
}

resource "azurerm_storage_data_lake_gen2_filesystem" "synapse_storage" {
  name               = "synapselake"
  storage_account_id = azurerm_storage_account.synapse_storage.id
}
