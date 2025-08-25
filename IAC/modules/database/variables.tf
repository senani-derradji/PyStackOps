variable "mysql_db_name" {
  type        = string
  default     = "db"
}

variable "rg_name" {
  type        = string
  default     = "rg-pystackops"
}

variable "location" {
  type        = string
  default     = "West US 3"
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
