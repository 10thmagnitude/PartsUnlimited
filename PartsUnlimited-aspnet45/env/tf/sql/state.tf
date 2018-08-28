terraform {
  backend "azurerm" {
    resource_group_name  = "cd-pu2-rg"
    storage_account_name = "cdpu2state"
    container_name       = "state"
    key                  = "sql.terraform.tfstate"
  }
}