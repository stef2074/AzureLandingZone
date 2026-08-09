provider "azurerm" {
  features {}

  subscription_id = var.development_subscription_id
}

provider "azurerm" {
  alias = "management"

  features {}

  subscription_id = var.management_subscription_id
}