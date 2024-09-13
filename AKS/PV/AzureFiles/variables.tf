variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
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

# Azure Files
variable "storage_account_name" {
  description = "The name of the Azure Storage Account"
  type        = string
}

variable "file_share_name" {
  description = "The name of the Azure File Share"
  type        = string
}

variable "pv_name" {
  description = "The name of the Persistent Volume"
  type        = string
}

variable "pvc_name" {
  description = "The name of the Persistent Volume Claim"
  type        = string
}

variable "secret_name" {
  description = "The name of the Kubernetes secret for Azure Storage credentials"
  type        = string
}

# Networking variables
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
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
