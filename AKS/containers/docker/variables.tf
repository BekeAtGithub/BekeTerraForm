#This file stores common variables - key value pairs, or other values
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for the resources"
  type        = string
  default     = "East US"
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}

variable "agent_vm_size" {
  description = "The size of the virtual machines in the AKS node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "agent_count" {
  description = "The number of agent nodes in the default pool"
  type        = number
  default     = 2
}

variable "client_id" {
  description = "The Client ID for the service principal"
  type        = string
}

variable "client_secret" {
  description = "The Client Secret for the service principal"
  type        = string
  sensitive   = true
}

# Azure Container Registry (ACR)
variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

# Web App variables
variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
}

variable "web_app_docker_image" {
  description = "The Docker image for the Web App"
  type        = string
}

variable "web_app_docker_image_tag" {
  description = "The Docker image tag for the Web App"
  type        = string
}

# Function App variables
variable "function_app_name" {
  description = "The name of the Function App"
  type        = string
}

variable "function_app_docker_image" {
  description = "The Docker image for the Function App"
  type        = string
}

variable "function_app_docker_image_tag" {
  description = "The Docker image tag for the Function App"
  type        = string
}

# Network variables
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = string
}

# Tags
variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
