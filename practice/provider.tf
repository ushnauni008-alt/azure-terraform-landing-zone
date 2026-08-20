terraform {
  backend "azurerm" {
    use_cli              = true
    resource_group_name  = "tfstate-rg"
    storage_account_name = "b18g94"
    container_name       = "tfstateusha"
    key                  = "practice.terraform.tfstate"

  }
  required_version = ">=1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}

provider "azurerm" {
  features {}
}

