#This file contains actual values for the variables declared in variables.tf
#provides more specific values for environment
resource_group_name = "myResourceGroup"
location            = "East US"
vnet_name           = "myVNet"
vnet_address_space  = ["10.0.0.0/16"]
subnet_name         = "mySubnet"
subnet_address_prefix = "10.0.1.0/24"
vm_name             = "myVM"
admin_username      = "azureuser"
admin_password      = "YourStrongPassword123!"
