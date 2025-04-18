output "id" {
  description = "ID del App Service Plan"
  value       = azurerm_service_plan.this.id
}

output "name" {
  description = "Nombre del App Service Plan"
  value       = azurerm_service_plan.this.name
}
