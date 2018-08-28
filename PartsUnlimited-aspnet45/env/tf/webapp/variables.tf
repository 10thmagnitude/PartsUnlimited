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
      name             = "cdpartsun2"
      rg_name_prefix   = "cd-pu2"
      plan_name_prefix = "cdpu2"
      app_name_prefix  = "cdpartsun2"
    }

    prod = {
      name             = "cdpartsun2"
      rg_name_prefix   = "cd-pu2"
      plan_name_prefix = "cdpu2"
      app_name_prefix  = "cdpartsun2"
    }
  }
}

variable "created_by" {}
variable "access_key" {}
variable "release" {}
