data "terraform_remote_state" "sql" {
  backend   = "azurerm"
  workspace = terraform.workspace

  config = {
    resource_group_name  = "cd-pu3-state"
    storage_account_name = "cdpu3state"
    container_name       = "state"
    key                  = "sql.terraform.tfstate"
    access_key           = var.access_key
  }
}

data "terraform_remote_state" "appinsights" {
  backend   = "azurerm"
  workspace = terraform.workspace

  config = {
    resource_group_name  = "cd-pu3-state"
    storage_account_name = "cdpu3state"
    container_name       = "state"
    key                  = "appinsights.terraform.tfstate"
    access_key           = var.access_key
  }
}

locals {
  app        = var.app
  env        = var.environment[terraform.workspace]
  secrets    = var.secrets[terraform.workspace]
  stack      = var.stack_config[terraform.workspace]
  created_by = var.created_by
  rg_prefix  = var.rg_prefix
  stack_name = local.stack["name"]

  env_name = terraform.workspace

  release = var.release

  location        = local.env["location"]
  rg_name         = "${local.rg_prefix}-${local.env_name}-${local.stack_name}"
  plan_name       = "${local.stack["plan_name_prefix"]}-${local.env_name}"
  app_name        = "${local.stack["app_name_prefix"]}-${local.env_name}"
  plan_tier       = local.env["webapp_tier"]
  plan_sku        = local.env["webapp_sku"]
  slots           = compact(split(",", local.env["webapp_slots"]))
  db_con_str      = data.terraform_remote_state.sql.connection_string
  appinsights_key = data.terraform_remote_state.appinsights.instrumentation_key

  tags = {
    environment = terraform.workspace
    created_by  = local.created_by
    release     = local.release
    app         = local.app
  }
}

resource "azurerm_resource_group" "apprg" {
  name     = local.rg_name
  location = local.location

  tags = local.tags
}

resource "azurerm_app_service_plan" "plan" {
  name                = local.plan_name
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name

  sku {
    tier = local.plan_tier
    size = local.plan_sku
  }

  tags = local.tags

}

resource "azurerm_app_service" "webapp" {
  name                = local.app_name
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  #   site_config {
  #     dotnet_framework_version = "v4.0"
  #   }

  app_settings = {
    "SlotName"                                    = "prod"
    "Environment"                                 = local.env_name
    "Keys:ApplicationInsights:InstrumentationKey" = local.appinsights_key
  }
  connection_string {
    name  = "DefaultConnectionString"
    type  = "SQLServer"
    value = local.db_con_str
  }
  tags = local.tags

}

resource "azurerm_app_service_slot" "slots" {
  count               = length(local.slots)
  name                = element(local.slots, count.index)
  app_service_name    = azurerm_app_service.webapp.name
  location            = azurerm_resource_group.apprg.location
  resource_group_name = azurerm_resource_group.apprg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  #   site_config {
  #     dotnet_framework_version = "v4.0"
  #   }

  app_settings = {
    "SlotName"                                    = "${element(local.slots, count.index)}"
    "Environment"                                 = "${local.env_name}"
    "Keys:ApplicationInsights:InstrumentationKey" = "${local.appinsights_key}"
  }
  connection_string {
    name  = "DefaultConnectionString"
    type  = "SQLServer"
    value = local.db_con_str
  }
  tags = local.tags

}
