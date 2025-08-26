terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "1.7.6"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}
