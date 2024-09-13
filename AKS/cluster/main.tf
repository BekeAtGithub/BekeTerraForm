
provider "azurerm" {
  features {}
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

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "calico"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true
  }

  tags = var.tags
}

# AKS Node Pool (Optional - if you want to add additional node pools)
resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
  name                  = "additionalpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.agent_vm_size
  node_count            = var.agent_count
}

# Log Analytics Workspace for AKS monitoring
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${var.aks_cluster_name}-log"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
}

# Attach Log Analytics to AKS for monitoring
resource "azurerm_kubernetes_cluster" "aks_with_monitoring" {
  depends_on          = [azurerm_kubernetes_cluster.aks, azurerm_log_analytics_workspace.log_analytics]
  
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id  = azurerm_log_analytics_workspace.log_analytics.id
    }
  }
}
