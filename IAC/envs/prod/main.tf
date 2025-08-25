module network {
  source = "../../modules/network"
  rg_name = var.rg_name
  location = var.location
  vnet_name = var.vnet_name
  address_space = var.address_space
  subnet_name = var.subnet_name
  subnet_perfix = var.subnet_perfix
  nsg_name = var.nsg_name
}

module compute {
  source = "../../modules/compute"
  public_ip_name = var.public_ip_name
  location = module.network.location
  resource_group_name = module.network.rg_name
  nic_name = var.nic_name
  subnet_id = module.network.subnet_id
  nsg_id = module.network.nsg_id
  vm_name = var.vm_name
  vm_size = var.vm_size
  admin_username = var.admin_username
}