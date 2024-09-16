##This primary file defines managed disk primary values
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

# Azure Managed Disk
resource "azurerm_managed_disk" "managed_disk" {
  name                 = var.disk_name
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = var.disk_size_gb
}

# Kubernetes Persistent Volume (PV) using Azure Managed Disk
resource "kubernetes_persistent_volume" "managed_disk_pv" {
  metadata {
    name = var.pv_name
  }

  spec {
    capacity = {
      storage = "${var.disk_size_gb}Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      azure_disk {
        disk_name    = azurerm_managed_disk.managed_disk.name
        disk_uri     = azurerm_managed_disk.managed_disk.id
        caching_mode = "None"
        fs_type      = "ext4"
      }
    }
  }
}

# Kubernetes Persistent Volume Claim (PVC)
resource "kubernetes_persistent_volume_claim" "managed_disk_pvc" {
  metadata {
    name = var.pvc_name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "${var.disk_size_gb}Gi"
      }
    }

    volume_name = kubernetes_persistent_volume.managed_disk_pv.metadata[0].name
  }
}
