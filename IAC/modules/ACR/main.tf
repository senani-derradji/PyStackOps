resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.acr_sku
  admin_enabled            = true
  acr_login_server         = "${var.acr_name}.azurecr.io"
}