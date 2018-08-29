provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

locals {
  env        = "${var.environment[terraform.workspace]}"
  secrets    = "${var.secrets[terraform.workspace]}"
  stack      = "${var.stack_config[terraform.workspace]}"
  created_by = "${var.created_by}"
  rg_prefix  = "${var.rg_prefix}"
  stack_name = "${local.stack["name"]}"

  env_name = "${terraform.workspace}"
  release  = "${var.release}"

  location           = "${local.env["location"]}"
  rg_name            = "${local.rg_prefix}-${local.env_name}-${local.stack_name}"
  sql_server_name    = "${local.stack["sql_server_name_prefix"]}${local.env_name}"
  sql_admin_username = "${local.stack["sql_admin_username"]}"
  sql_admin_password = "${local.secrets["sql_admin_password"]}"
  db_name            = "${local.stack["db_name"]}"
  db_edition         = "${local.env["db.edition"]}"
  db_sku             = "${local.env["db.sku"]}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.rg_name}"
  location = "${local.location}"

  tags {
    environment = "${terraform.workspace}"
    created_by  = "${local.created_by}"
  }
}

resource "azurerm_sql_server" "sql" {
  name                         = "${local.sql_server_name}"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  location                     = "${local.location}"
  version                      = "12.0"
  administrator_login          = "${local.sql_admin_username}"
  administrator_login_password = "${local.sql_admin_password}"

  tags {
    environment = "${terraform.workspace}"
    created_by  = "${local.created_by}"
    release     = "${local.release}"
  }
}

resource "azurerm_sql_database" "db" {
  name                = "${local.db_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${local.location}"
  server_name         = "${azurerm_sql_server.sql.name}"

  edition                          = "${local.db_edition}"
  requested_service_objective_name = "${local.db_sku}"

  tags {
    environment = "${terraform.workspace}"
    created_by  = "${local.created_by}"
    release     = "${local.release}"
  }
}

resource "azurerm_sql_firewall_rule" "db_fw" {
  name                = "AllowAzureServicesAccess"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_sql_server.sql.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}