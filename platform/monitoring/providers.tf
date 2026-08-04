provider "azurerm" {
  features {}

  subscription_id = var.management_subscription_id
}

provider "azurerm" {
  alias = "connectivity"

  features {}

  subscription_id = var.connectivity_subscription_id
}

provider "azurerm" {
  alias = "development"

  features {}

  subscription_id = var.development_subscription_id
}