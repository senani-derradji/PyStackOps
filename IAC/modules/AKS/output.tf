output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.vm.admin_username
}

output "admin_ssh_key" {
  value = tolist(azurerm_linux_virtual_machine.vm.admin_ssh_key)[0].public_key
}


output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}
