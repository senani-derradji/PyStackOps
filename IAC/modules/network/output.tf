output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  sensitive   = false
  description = "virtual network id"
}

output "subnet_id" {
  value       = azurerm_subnet.sb.id
  sensitive   = false
  description = "subnet id"
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "location" {
  value = azurerm_resource_group.rg.location
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}