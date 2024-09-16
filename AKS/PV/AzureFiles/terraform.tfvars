#This file defines the values for the variables, which can be customized as per your environment.
resource_group_name        = "my-resource-group"
location                   = "East US"
aks_cluster_name           = "my-aks-cluster"
dns_prefix                 = "aksdns"
client_id                  = "YOUR_CLIENT_ID"
client_secret              = "YOUR_CLIENT_SECRET"
storage_account_name        = "mystorageaccount"
file_share_name             = "myfileshare"
pv_name                    = "azurefile-pv"
pvc_name                   = "azurefile-pvc"
secret_name                = "azure-file-secret"
vnet_name                  = "my-vnet"
vnet_address_space         = ["10.0.0.0/16"]
subnet_name                = "my-subnet"
subnet_address_prefix      = "10.0.1.0/24"
tags                       = {
  environment = "production"
}
