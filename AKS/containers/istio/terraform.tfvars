resource_group_name        = "my-resource-group"
location                   = "East US"
aks_cluster_name           = "my-aks-cluster"
dns_prefix                 = "aksdns"
acr_name                   = "myacr"
client_id                  = "YOUR_CLIENT_ID"
client_secret              = "YOUR_CLIENT_SECRET"
vnet_name                  = "my-vnet"
vnet_address_space         = ["10.0.0.0/16"]
subnet_name                = "my-subnet"
subnet_address_prefix      = "10.0.1.0/24"
istio_namespace            = "istio-system"
tags                       = {
  environment = "production"
}
