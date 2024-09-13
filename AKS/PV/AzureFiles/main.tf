#Configure a Persistent Volume (PV) and Persistent Volume Claim (PVC) in AKS to use the Azure File Share.
#create Storage Account and File Share
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

# Azure Storage Account for Azure Files
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

# Azure File Share for Persistent Volume
resource "azurerm_storage_share" "file_share" {
  name                 = var.file_share_name
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 5
}

# Kubernetes Persistent Volume for Azure Files
resource "kubernetes_persistent_volume" "azure_file_pv" {
  metadata {
    name = var.pv_name
  }

  spec {
    capacity = {
      storage = "5Gi"
    }

    access_modes = ["ReadWriteMany"]

    persistent_volume_source {
      azure_file {
        secret_name     = var.secret_name
        share_name      = azurerm_storage_share.file_share.name
        read_only       = false
      }
    }
  }
}

# Kubernetes Persistent Volume Claim (PVC)
resource "kubernetes_persistent_volume_claim" "azure_file_pvc" {
  metadata {
    name = var.pvc_name
  }

  spec {
    access_modes = ["ReadWriteMany"]

    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

# Kubernetes secret to store Azure Storage credentials
resource "kubernetes_secret" "azure_file_secret" {
  metadata {
    name = var.secret_name
  }

  data = {
    azurestorageaccountname = base64encode(azurerm_storage_account.storage.name)
    azurestorageaccountkey  = base64encode(azurerm_storage_account.storage.primary_access_key)
  }
}
