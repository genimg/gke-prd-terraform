terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.85.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "d-vuelo-st-rg-eus2-e59p"
      storage_account_name = "dvuelosteus21r4d"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  #skip_provider_registration = "true"
  
  #subscription_id   = "81d154b1-513f-4090-beeb-1043171b78a8"
  #client_id = "76522489-a116-45d3-abcc-0460064a0154"
  #client_secret = ""
  #tenant_id = "ce4a6448-2ace-405a-808d-6967d2758d65"
  subscription_id   = "33d9474f-6004-49f1-a25a-4d8cc8912608"
  client_id = "488ecb0d-3c04-4078-8461-bdc5061ef51c"
  client_secret = "idZ8Q~xkELJRoK014_JLsWebFUGISFxCJUENnbn_"
  tenant_id = "ce4a6448-2ace-405a-808d-6967d2758d65"
}