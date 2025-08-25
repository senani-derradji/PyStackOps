resource "azurerm_mysql_flexible_server" "mysqlserver" {
  name                   = var.mysql_name
  resource_group_name    = var.rg_name
  location               = var.location
  administrator_login    = var.mysql_admin
  administrator_password = var.mysql_password

  sku_name   = var.mysql_sku_name
  storage {
    size_gb = var.mysql_storage_gb
  }
  version    = "8.0.21"

  backup_retention_days       = 7
  geo_redundant_backup_enabled = false
}

resource "azurerm_mysql_flexible_database" "mysqldb" {
  name      = var.mysql_db_name
  resource_group_name = var.rg_name
  server_name         = azurerm_mysql_flexible_server.mysqlserver.name
  charset   = "utf8"
  collation = "utf8_unicode_ci"
}
