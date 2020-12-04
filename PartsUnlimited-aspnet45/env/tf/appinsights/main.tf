provider "azurerm" {
  features {}
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

locals {
  app              = "${var.app}"
  env              = "${var.environment[terraform.workspace]}"
  secrets          = "${var.secrets[terraform.workspace]}"
  stack            = "${var.stack_config[terraform.workspace]}"
  rg_prefix        = "${var.rg_prefix}"
  created_by       = "${var.created_by}"
  stack_name       = "${local.stack["name"]}"

  env_name         = "${terraform.workspace}"
  release          = "${var.release}"

  location         = "${local.env["location"]}"
  rg_name          = "${local.rg_prefix}-${local.env_name}-${local.stack_name}"
  app_name         = "${local.stack["web_name_prefix"]}-${local.env_name}"
  appinsights_name = "${local.stack["ai_name_prefix"]}-ai-${local.env_name}"
}


data "template_file" "webtests" {
  template = "${file("./webtests.json")}"
}

resource "azurerm_resource_group" "airg" {
  name          = "${local.rg_name}"
  location      = "${local.location}"

  tags {
    environment = "${terraform.workspace}"
    created_by  = "${local.created_by}"
    release     = "${local.release}"
    app         = "${local.app}"
  }
}

resource "azurerm_application_insights" "appinsights" {
  name                = "${local.appinsights_name}"
  location            = "${azurerm_resource_group.airg.location}"
  resource_group_name = "${azurerm_resource_group.airg.name}"
  application_type    = "web"

  tags = {
    environment       = "${terraform.workspace}"
    created_by        = "${local.created_by}"
    webapp            = "${local.app_name}"
    release           = "${local.release}"
    app               = "${local.app}"
  }
}

resource "azurerm_template_deployment" "template-webtests" {
  name                = "${local.appinsights_name}-webtests"
  resource_group_name = "${azurerm_resource_group.airg.name}"
  template_body       = "${data.template_file.webtests.rendered}"
  parameters {
    "appInsightsName" = "${local.appinsights_name}"
    "baseUrl"         = "http://${local.app_name}.azurewebsites.net"
    "location"        = "${local.location}"
  }
  deployment_mode     = "Incremental"

  depends_on          = ["azurerm_application_insights.appinsights"]
}
