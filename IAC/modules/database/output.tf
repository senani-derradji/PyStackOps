output "test_mysql_admin" {
  value = azurerm_mysql_flexible_server.mysqlserver.administrator_login
}

output "test_mysql_fqdn" {
  value = azurerm_mysql_flexible_server.mysqlserver.fqdn
}


output "test_mysql_db_name" {
  value       = azurerm_mysql_flexible_server.mysqlserver.name
  sensitive   = false
}

output "test_mysql_password" {
  value       = var.mysql_password
  sensitive   = true
}