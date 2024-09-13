
output "synapse_workspace_id" {
  description = "The ID of the Synapse Analytics workspace"
  value       = azurerm_synapse_workspace.synapse.id
}

output "synapse_sql_pool_id" {
  description = "The ID of the Synapse SQL pool"
  value       = azurerm_synapse_sql_pool.synapse_sql_pool.id
}

output "synapse_workspace_url" {
  description = "The URL of the Synapse Analytics workspace"
  value       = azurerm_synapse_workspace.synapse.web_endpoint
}
