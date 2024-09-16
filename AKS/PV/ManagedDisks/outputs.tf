#This file defines outputs for the resources to expose
output "aks_cluster_name" {
  description = "The name of the AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "managed_disk_name" {
  description = "The name of the Azure Managed Disk"
  value       = azurerm_managed_disk.managed_disk.name
}

output "pv_name" {
  description = "The name of the Persistent Volume"
  value       = kubernetes_persistent_volume.managed_disk_pv.metadata[0].name
}

output "pvc_name" {
  description = "The name of the Persistent Volume Claim"
  value       = kubernetes_persistent_volume_claim.managed_disk_pvc.metadata[0].name
}
