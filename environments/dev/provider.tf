terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"       
    storage_account_name = "tfstateabdessamad2026"    
    container_name       = "tfstate"                  
    key                  = "dev.terraform.tfstate"   
  }
}

provider "azurerm" {
  features {}
}