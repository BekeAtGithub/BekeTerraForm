#File is used to define outputs - here it is for VM private IP and VM name
output "vm_private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "vm_name" {
  value = azurerm_virtual_machine.vm.name
}
