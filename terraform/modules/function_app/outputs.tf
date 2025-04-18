output "function_app_id" {
  description = "ID de la Function App"
  value       = azurerm_linux_function_app.this.id
}

output "function_app_url" {
  description = "URL de la Function App"
  value       = azurerm_linux_function_app.this.default_hostname
}

output "function_app_identity" {
  description = "Identidad de la Function App"
  value       = azurerm_linux_function_app.this.identity[0].principal_id
}