#Key output from deployment 
#Kasten10 Web console address output
output "aks_cluster_name" {
  description = "The name of the AKS Cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kasten_k10_url" {
  description = "The URL of the Kasten K10 web console"
  value       = helm_release.kasten_k10.status[0].load_balancer[0].ingress[0].ip
}
