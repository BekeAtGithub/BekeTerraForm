
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}

variable "synapse_workspace_name" {
  description = "The name of the Azure Synapse Analytics workspace"
  type        = string
}

variable "sql_administrator_login" {
  description = "The administrator login for the Synapse SQL pool"
  type        = string
}

variable "sql_administrator_password" {
  description = "The password for the Synapse SQL pool administrator"
  type        = string
  sensitive   = true
}

variable "sql_pool_name" {
  description = "The name of the Synapse SQL pool"
  type        = string
}

# Variables for the data lake storage
variable "storage_account_name" {
  description = "The name of the storage account for the Data Lake"
  type        = string
}

# Optional networking variables
variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "myVNet"
}

variable "vnet_address_space" {
  description = "The address space of the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "synapse_subnet_name" {
  description = "The name of the Synapse subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = string
}
