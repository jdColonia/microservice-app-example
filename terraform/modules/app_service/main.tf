resource "azurerm_linux_web_app" "this" {
  for_each = var.microservices

  name                = "microservices-${each.key}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id

  site_config {
    always_on        = true
    app_command_line = ""
    application_stack {
      docker_image_name     = "${var.acr_login_server}/${each.value.image_name}"
      docker_registry_url = "https://${var.acr_login_server}"
      docker_registry_username = data.azurerm_container_registry.acr.admin_username
      docker_registry_password = data.azurerm_container_registry.acr.admin_password
    }

    # Configuración adicional recomendada
    health_check_path = "/healthz" 
    health_check_eviction_time_in_min = 2
    ftps_state       = "Disabled"
    http2_enabled    = true
  }

  app_settings = merge(each.value.env_vars, {
    "WEBSITES_PORT"                      = each.value.container_port
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_ENABLE_CI"                   = "true"
  })

  identity {
    type = "SystemAssigned"
  }
}

# Otorgar acceso a Key Vault
resource "azurerm_key_vault_access_policy" "app_service" {
  for_each = var.microservices

  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_linux_web_app.this[each.key].identity[0].principal_id

  secret_permissions = [
    "Get", "List",
  ]
}

# Permisos para extraer imágenes de ACR
resource "azurerm_role_assignment" "acr_pull" {
  for_each = var.microservices

  principal_id         = azurerm_linux_web_app.this[each.key].identity[0].principal_id
  role_definition_name = "AcrPull"
  scope               = data.azurerm_container_registry.acr.id
}

data "azurerm_container_registry" "acr" {
  name = replace(var.acr_login_server, ".azurecr.io", "")
  resource_group_name = var.resource_group_name
}

data "azurerm_client_config" "current" {}