variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "environment" {
  type = "map"
}

variable "secrets" {
  type = "map"
}

variable "stack_config" {
  type = "map"

  default = {
    dev = {
      name            = "appinsights"
      rg_name_prefix  = "cd-pu3"
      ai_name_prefix  = "cdpu3"
      web_name_prefix = "cdpartsun3"
    }

    prod = {
      name            = "appinsights"
      rg_name_prefix  = "cd-pu3"
      ai_name_prefix  = "cdpu3"
      web_name_prefix = "cdpartsun3"
    }
  }
}

variable "created_by" {}
variable "access_key" {}
variable "rg_prefix" {}
variable "release" {}
variable "app" {}
