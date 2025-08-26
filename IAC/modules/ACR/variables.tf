variable "acr_name" {
  type        = string
  default     = "acr_container_reg"
  description = "The name of the Azure Container Registry."
}

variable "acr_sku" {
  type        = string
  default     = "Basic"
  description = "The SKU of the Azure Container Registry. Possible values are Basic, Standard, and Premium."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Azure Container Registry."
}

variable "location" {
  type        = string
  description = "The Azure region where the Azure Container Registry will be created."
}

