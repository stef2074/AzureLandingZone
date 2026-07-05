terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "stlandingzonetfstate001"
    container_name       = "tfstate"
    key                  = "bootstrap.tfstate"
  }
}
