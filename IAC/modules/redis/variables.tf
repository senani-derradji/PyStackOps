variable "redis_name" {
  type        = string
  default     = "redis-cache"
}

variable "rg_name" {
  type        = string
  default     = "rg-pystackops"
}

variable "location" {
  type        = string
  default     = "West US 3"
}

variable "redis_capacity" {
  type        = number
  default     = 0
}

variable "redis_family" {
  type        = string
  default     = "C"
}

variable "redis_sku_name" {
  type        = string
  default     = "Standard"
}
