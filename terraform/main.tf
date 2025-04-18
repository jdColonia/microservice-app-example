provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
  subscription_id = var.subscription_id
}

locals {
  resource_name_prefix = var.project_name
}

module "resource_group" {
  source = "./modules/resource_group"

  name     = "${local.resource_name_prefix}-rg"
  location = var.location
}

module "networking" {
  source = "./modules/networking"

  resource_group_name = module.resource_group.name
  location            = var.location
  vnet_name           = "${local.resource_name_prefix}-vnet"
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
}

module "container_registry" {
  source = "./modules/container_registry"

  name                = "${replace(local.resource_name_prefix, "-", "")}acr"
  resource_group_name = module.resource_group.name
  location            = var.location
  sku                 = var.acr_sku
}

module "key_vault" {
  source = "./modules/key_vault"

  name                = "${replace(local.resource_name_prefix, "-", "")}kv"
  resource_group_name = module.resource_group.name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

module "service_plan" {
  source              = "./modules/service_plan"
  name                = "${local.resource_name_prefix}-asp"
  location            = var.location
  resource_group_name = module.resource_group.name
}

module "app_service" {
  source = "./modules/app_service"

  resource_group_name = module.resource_group.name
  location            = var.location
  app_service_plan_id = module.service_plan.id
  subnet_id           = module.networking.subnet_ids["application"]
  acr_login_server    = module.container_registry.login_server
  microservices       = var.microservices
  key_vault_id        = module.key_vault.key_vault_id
}


module "function_app" {
  source = "./modules/function_app"

  name                = "${local.resource_name_prefix}-func"
  resource_group_name = module.resource_group.name
  location            = var.location
  subnet_id           = module.networking.subnet_ids["application"]
  app_service_plan_id = module.service_plan.id
  acr_login_server    = module.container_registry.login_server
}

module "static_web_app" {
  source = "./modules/static_web_app"

  name                = "${local.resource_name_prefix}-swa"
  resource_group_name = module.resource_group.name
  location            = var.location
  sku                 = var.static_web_app_sku
}

data "azurerm_client_config" "current" { }