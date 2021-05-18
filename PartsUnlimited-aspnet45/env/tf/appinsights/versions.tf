
terraform {
  required_version = ">= 0.15"

  required_providers {
    azurerm = {
      version = "~> 2.0"
      source  = "hashicorp/azurerm"
    }

    template = {
      version = "~> 2.0"
      source  = "hashicorp/template"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
