#This file defines outputs for the resources to expose
output "aks_cluster_name" {
  description = "The name of the AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "nginx_ingress_service_ip" {
  description = "The external IP of the NGINX ingress service"
  value       = helm_release.nginx_ingress.status[0].load_balancer[0].ingress[0].ip
}

output "example_chart_release_name" {
  description = "The name of the deployed Helm release"
  value       = helm_release.example_chart.name
}
