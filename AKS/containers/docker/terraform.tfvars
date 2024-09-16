#defined variable expansion pack 
resource_group_name        = "my-resource-group"
location                   = "East US"
aks_cluster_name           = "my-aks-cluster"
dns_prefix                 = "aksdns"
acr_name                   = "myacr"
web_app_name               = "my-web-app"
web_app_docker_image       = "my-web-app-image"
web_app_docker_image_tag   = "latest"
function_app_name          = "my-function-app"
function_app_docker_image  = "my-function-app-image"
function_app_docker_image_tag = "latest"
client_id                  = "YOUR_CLIENT_ID"
client_secret              = "YOUR_CLIENT_SECRET"
vnet_name                  = "my-vnet"
vnet_address_space         = ["10.0.0.0/16"]
subnet_name                = "my-subnet"
subnet_address_prefix      = "10.0.1.0/24"
tags                       = {
  environment = "production"
}
