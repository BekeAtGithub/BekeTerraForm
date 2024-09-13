
resource_group_name        = "my-resource-group"
location                   = "East US"
aks_cluster_name           = "my-aks-cluster"
dns_prefix                 = "aksdns"
client_id                  = "YOUR_CLIENT_ID"
client_secret              = "YOUR_CLIENT_SECRET"
disk_name                  = "my-managed-disk"
disk_size_gb               = 10
pv_name                    = "manageddisk-pv"
pvc_name                   = "manageddisk-pvc"
vnet_name                  = "my-vnet"
vnet_address_space         = ["10.0.0.0/16"]
subnet_name                = "my-subnet"
subnet_address_prefix      = "10.0.1.0/24"
tags                       = {
  environment = "production"
}
