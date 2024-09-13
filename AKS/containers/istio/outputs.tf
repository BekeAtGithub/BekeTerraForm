
output "aks_cluster_name" {
  description = "The name of the AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "istio_ingress_service_ip" {
  description = "The external IP of the Istio Ingress service"
  value       = helm_release.istio_ingress.status[0].load_balancer[0].ingress[0].ip
}

output "acr_login_server" {
  description = "The Azure Container Registry login server"
  value       = azurerm_container_registry.acr.login_server
}
