#This file defines outputs for the resources to expose
output "aks_cluster_name" {
  description = "The name of the AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account"
  value       = azurerm_storage_account.storage.name
}

output "file_share_name" {
  description = "The name of the Azure File Share"
  value       = azurerm_storage_share.file_share.name
}

output "pv_name" {
  description = "The name of the Persistent Volume"
  value       = kubernetes_persistent_volume.azure_file_pv.metadata[0].name
}

output "pvc_name" {
  description = "The name of the Persistent Volume Claim"
  value       = kubernetes_persistent_volume_claim.azure_file_pvc.metadata[0].name
}
