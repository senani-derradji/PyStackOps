variable vnet_name {
  type        = string
  default     = "vnet"
}

variable subnet_name {
  type        = string
  default     = "subnet"
}

variable "rg_name" {
  type        = string
  default     = "pystackops"
}

variable "location" {
  type        = string
  default     = "West US 2"
}


variable "address_space" {
  type        = list(string)
}

variable "subnet_perfix" {
  type        = list(string)
}


variable "acr_name" {
  type        = string
  default     = "acrcontainerreg"
}

variable "acr_sku" {
  type        = string
  default     = "Basic"
}

