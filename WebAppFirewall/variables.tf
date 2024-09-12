#This file stores common values
variable "location" {
  default = "eastus"
}

variable "resource_group_name" {
  default = "myResourceGroup"
}

variable "vnet_name" {
  default = "myVnet"
}

variable "subnet_name" {
  default = "mySubnet"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  default = "10.0.1.0/24"
}
