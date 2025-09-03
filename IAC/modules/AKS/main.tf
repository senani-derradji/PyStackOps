resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = var.aks_identity_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix         = var.aks_dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }
  identity {
    type = "UserAssigned"
    user_assigned_identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }
  role_based_access_control {
    enabled = true
  }
  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }

}