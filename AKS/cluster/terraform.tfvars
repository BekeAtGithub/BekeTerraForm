#extended values for the variables - varies per environment
resource_group_name     = "aks-rg"
location                = "East US"
aks_cluster_name        = "myAKSCluster"
dns_prefix              = "aksdns"
agent_vm_size           = "Standard_DS2_v2"
agent_count             = 2
client_id               = "YOUR_CLIENT_ID"
client_secret           = "YOUR_CLIENT_SECRET"
vnet_name               = "aks-vnet"
vnet_address_space      = ["10.0.0.0/16"]
subnet_name             = "aks-subnet"
subnet_address_prefix   = "10.0.1.0/24"
tags                    = {
  environment = "development"
}
