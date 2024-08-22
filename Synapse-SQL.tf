#Define the Provider 
provider "azurerm" {
  features{}
}

#Create an RG
resource "azurerm_resource_group" "rg" {
  name = "nameOfSynapseRG"
  location = "West US"
}

#Create an Azure Synapse Workspace
resource "azurerm_synapse_workspace" "synapse" {
  name = "nameOfSynapseWorkspace"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2
  sql_administrator_login = "sqladmin"
  sql_administrator_password = "ClearTextPassword-UseVariable"
  managed_virtual_network_enabled = true

  identity {
    type = "SystemAssigned"
  }
}

#Create a SQL Pool
resource = "azurerm_synapse_sql_pool" "sqlpool" {
  name = "nameOfSQLpool"
  resource_group_name = auzrerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku {
    name = "DW100c"
    capacity = 100
  }
}

#Create a Data Lake account
resource "azurerm_storage_account" "DataLakeAccount" {
  name = "nameOfDataLakeAccount"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_stroage_data_lake_gen2_filesystem" "DataLakeFilesystem" {
  name = "nameOfDataLakeFilesystem"
  storage_account_id = azurerm_storage_account.example.id
}

#Create a Managed Private Endpoint
resource "azurerm_synapse_private_link_hub" "PrivateEndpoint" {
  name = "nameOfPrivateLinkHub"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  synapse_workspace_id = azurerm_synapse_worksapce.synapse.id

  managed_private_endpoints {
    name = "nameOfEndpoint"
    target_resource_id = azurerm_storage_account.example.id
    subresource_name = "blob"
  }
}

#Add output for Synapse Workspace after Deployment
output "synapse_workspace_endpoint" {
  value = azurerm_synapse_workspace.synapse.web_endpoint
}

output "synapse_workspace_id" {
  value = azurerm_synapse_workspace.synapse.id
}
