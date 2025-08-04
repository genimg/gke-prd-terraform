terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.85.0"
    }
  }
  backend "azurerm" {
    subscription_id      = "33d9474f-6004-49f1-a25a-4d8cc8912608"
    resource_group_name  = "d-vuelo-st-rg-eus2-e59p"
    storage_account_name = "dvuelosteus21r4d"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "random" {}

provider "azurerm" {
  skip_provider_registration = true 
  features {}
}