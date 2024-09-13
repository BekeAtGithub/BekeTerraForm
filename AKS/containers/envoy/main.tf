#This file contains the resources for deploying AKS, ACR, and the Envoy container in the cluster.
#use Azure Container Registry (ACR) to store the Envoy Docker image and configure it to be deployed into the AKS cluster.

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

# Azure Container Registry (ACR) for storing Envoy Docker image
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Grant AKS cluster access to ACR
resource "azurerm_role_assignment" "aks_acr_role" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}

# Kubernetes deployment of Envoy on AKS
resource "kubernetes_deployment" "envoy" {
  metadata {
    name      = var.envoy_deployment_name
    namespace = var.k8s_namespace
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "envoy"
      }
    }

    template {
      metadata {
        labels = {
          app = "envoy"
        }
      }

      spec {
        container {
          name  = "envoy"
          image = "${azurerm_container_registry.acr.login_server}/${var.envoy_docker_image}:${var.envoy_docker_image_tag}"

          ports {
            container_port = 10000
          }

          volume_mount {
            name       = "envoy-config"
            mount_path = "/etc/envoy/envoy.yaml"
            sub_path   = "envoy.yaml"
          }
        }

        volume {
          name = "envoy-config"

          config_map {
            name = kubernetes_config_map.envoy_config.metadata[0].name
          }
        }
      }
    }
  }
}

# Kubernetes ConfigMap for Envoy configuration
resource "kubernetes_config_map" "envoy_config" {
  metadata {
    name      = "envoy-config"
    namespace = var.k8s_namespace
  }

  data = {
    "envoy.yaml" = file("${path.module}/envoy.yaml")
  }
}

# Kubernetes service for Envoy
resource "kubernetes_service" "envoy_service" {
  metadata {
    name      = "envoy-service"
    namespace = var.k8s_namespace
  }

  spec {
    selector = {
      app = "envoy"
    }

    port {
      protocol    = "TCP"
      port        = 10000
      target_port = 10000
    }

    type = "LoadBalancer"
  }
}
