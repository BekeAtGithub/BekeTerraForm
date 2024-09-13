#defines core AKS cluster to install Kasten K10 
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

# Helm release for Kasten K10
resource "helm_release" "kasten_k10" {
  name       = "kasten-k10"
  repository = "https://charts.kasten.io"
  chart      = "k10"
  namespace  = var.kasten_namespace
  version    = "4.0.0"  # Update to the latest stable version

  create_namespace = true

  values = [
    file("${path.module}/kasten-values.yaml")  # Optional custom values
  ]
}
