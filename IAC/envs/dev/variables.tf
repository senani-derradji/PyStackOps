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

variable "nsg_name" {
  type    = string
  default = "nsg"
}

variable "public_ip_name" {
  type    = string
  default = "publicIP"
}

variable "nic_name" {
  type    = string
  default = "nic"
}

variable "vm_name" {
  type    = string
  default = "vm-dev"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "derradji"
}

variable "mysql_name" { type = string }
variable "mysql_admin" { type = string }
variable "mysql_password" { type = string }
variable "mysql_sku_name" { type = string }
variable "mysql_storage_gb" { type = number }
variable "mysql_db_name" { type = string }

variable "redis_name" {
  type        = string
  default     = "redis-cache"
}

variable "redis_sku_name" {
  type        = string
  default     = "Standard"
}

variable "redis_capacity" {
  type        = number
  default     = 0
}

variable "redis_family" {
  type        = string
  default     = "C"
}

