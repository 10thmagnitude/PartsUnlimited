terraform {
  backend "azurerm" {
    resource_group_name  = "cd-pu3-state"
    storage_account_name = "cdpu3state"
    container_name       = "state"
    key                  = "appinsights.terraform.tfstate"
  }
}

