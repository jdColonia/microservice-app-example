resource "azurerm_storage_account" "this" {
  name                     = "${replace(var.name, "-", "")}sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_linux_function_app" "this" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = var.app_service_plan_id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  site_config {
    application_stack {
      docker {
        registry_url = "https://${var.acr_login_server}"
        image_name   = "log-message-processor"
        image_tag    = "latest"
        registry_username = data.azurerm_container_registry.acr.admin_username
        registry_password = data.azurerm_container_registry.acr.admin_password
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

data "azurerm_container_registry" "acr" {
  name = replace(var.acr_login_server, ".azurecr.io", "")
  resource_group_name = var.resource_group_name
}