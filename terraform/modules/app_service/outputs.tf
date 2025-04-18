output "app_service_ids" {
  description = "IDs de los App Services"
  value = {
    for k, v in azurerm_linux_web_app.this : k => v.id
  }
}

output "app_service_urls" {
  description = "URLs de los App Services"
  value = {
    for k, v in azurerm_linux_web_app.this : k => "https://${v.default_hostname}"
  }
}

output "app_service_identities" {
  description = "Identidades de los App Services"
  value = {
    for k, v in azurerm_linux_web_app.this : k => v.identity[0].principal_id
  }
}