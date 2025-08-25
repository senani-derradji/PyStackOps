variable "rg_name" {
  type        = string
  default     = "rg"
  description = "resource group name of network module"
}

variable "location" {
  type        = string
  default     = "West US 2"
  description = "location of network module"
}

variable "vnet_name" {
    type        = string
    default     = "vnet"
    description = "virtual network of network module"
}

variable "address_space" {
  type        = list(string)
  default     = ["192.168.0.0/24"]
  description = "address space of network module"
}

variable "subnet_perfix" {
  type        = list(string)
  default     = ["192.168.0.0/26"]
  description = "address of subnet name"
}

variable "subnet_name" {
  type        = string
  default     = "subnet_name"
  description = "subnet name of subnet resource"
}


variable "nsg_name" {
  type        = string
  default     = "nsg"
  description = "network security group name"
}
