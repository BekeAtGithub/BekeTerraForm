
output "aks_cluster_name" {
  description = "The name of the AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "envoy_service_ip" {
  description = "The external IP of the Envoy service"
  value       = kubernetes_service.envoy_service.status[0].load_balancer[0].ingress[0].ip
}

output "acr_login_server" {
  description = "The Azure Container Registry login server"
  value       = azurerm_container_registry.acr.login_server
}
