#expansion for values for the variables.tf file
resource_group_name        = "my-resource-group"
location                   = "East US"
aks_cluster_name           = "my-aks-cluster"
dns_prefix                 = "aksdns"
client_id                  = "YOUR_CLIENT_ID"
client_secret              = "YOUR_CLIENT_SECRET"
vnet_name                  = "my-vnet"
vnet_address_space         = ["10.0.0.0/16"]
subnet_name                = "my-subnet"
subnet_address_prefix      = "10.0.1.0/24"
k8s_namespace              = "default"
example_helm_release_name  = "my-example-release"
example_helm_chart         = "bitnami/mysql"
tags                       = {
  environment = "production"
}
