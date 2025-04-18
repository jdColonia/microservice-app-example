output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.networking.vnet_name
}

output "acr_login_server" {
  value = module.container_registry.login_server
}

output "key_vault_uri" {
  value = module.key_vault.key_vault_uri
}

output "app_service_urls" {
  value = module.app_service.app_service_urls
}

output "function_app_url" {
  value = module.function_app.function_app_url
}