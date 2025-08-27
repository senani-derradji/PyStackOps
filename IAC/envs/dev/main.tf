module network {
  source = "../../modules/network"
  rg_name = var.rg_name
  location = var.location
  vnet_name = var.vnet_name
  address_space = var.address_space
  subnet_name = var.subnet_name
  subnet_perfix = var.subnet_perfix
}

module acr {
  source = "../../modules/ACR"
  acr_name = var.acr_name
  acr_sku = var.acr_sku
  resource_group_name = module.network.rg_name
  location = module.network.location
}