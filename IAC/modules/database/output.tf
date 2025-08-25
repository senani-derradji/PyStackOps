output "mysql_admin" {
  value = azurerm_mysql_flexible_server.mysqlserver.administrator_login
}

output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.mysqlserver.fqdn
}


output "mysql_db_name" {
  value       = azurerm_mysql_flexible_server.mysqlserver.name
  sensitive   = false
}
