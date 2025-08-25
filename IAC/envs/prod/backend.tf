terraform {
  backend "azurerm" {
    resource_group_name   = "rg-tfstate"
    storage_account_name  = "tfstatepystackops"
    container_name        = "tfstate"
    key                   = "prod.terraform.tfstate"
  }
}