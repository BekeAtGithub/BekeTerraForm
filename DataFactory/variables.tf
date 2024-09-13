
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}

variable "adf_name" {
  description = "The name of the Data Factory"
  type        = string
}

# Optional variables for networking (if needed)
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "myVNet"
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "mySubnet"
}

variable "subnet_address_prefix" {
  description = "The address prefix of the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
