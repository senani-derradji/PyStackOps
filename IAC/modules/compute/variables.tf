variable "public_ip_name" {
  type        = string
}

variable "location" {
  type        = string
  default     = "West US 2"
}

variable "resource_group_name" {
  type        = string
  default     = "PyStackOps"
}

variable "nic_name" {
  type        = string
  default     = "nic"
}

variable "subnet_id" {
  type        = string
}

variable "vm_name" {
  type        = string
  default     = "myVM"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  default     = "derradji"
}

variable "nsg_id" {
  type        = string
}