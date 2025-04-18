output "static_web_app_id" {
  description = "ID de la Static Web App"
  value       = azurerm_static_web_app.this.id
}

output "static_web_app_url" {
  description = "URL de la Static Web App"
  value       = azurerm_static_web_app.this.default_host_name
}

output "static_web_app_api_key" {
  description = "API key de la Static Web App"
  value       = azurerm_static_web_app.this.api_key
  sensitive   = true
}