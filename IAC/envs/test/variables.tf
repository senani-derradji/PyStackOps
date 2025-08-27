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

variable "ssh_public_key" {
  type = string
}


# DB VARS
variable "mysql_db_name" {
  type        = string
  default     = "db"
}

variable "mysql_admin" {
  type        = string
  default     = "derradjidbs"
}

variable "mysql_password" {
  type        = string
  default     = "P@ssw0rd1234"
}

variable "mysql_name" {
    type        = string
    default     = "mysqlserver"
}

variable "mysql_sku_name" {
    type        = string
    default     = "B_Standard_B1ms"
}

variable "mysql_storage_gb" {
    type        = number
    default     = 32
}

