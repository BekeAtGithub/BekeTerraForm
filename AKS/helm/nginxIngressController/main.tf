#the main.tf file for nginx ingress controller
provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
    client_certificate      = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
    client_key              = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
    cluster_ca_certificate  = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.agent_count
    vm_size    = var.agent_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "calico"
  }

  tags = var.tags
}

# Helm release for NGINX Ingress Controller
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.k8s_namespace
  version    = "4.0.6"

  create_namespace = true

  values = [
    file("${path.module}/nginx-values.yaml")
  ]
}

# Example of installing another chart (optional)
resource "helm_release" "example_chart" {
  name       = var.example_helm_release_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = var.example_helm_chart
  namespace  = var.k8s_namespace

  values = [
    file("${path.module}/example-chart-values.yaml")
  ]

  create_namespace = false
}
