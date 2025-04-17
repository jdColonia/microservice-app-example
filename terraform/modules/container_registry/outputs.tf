output "id" {
  description = "ID del Container Registry"
  value       = azurerm_container_registry.this.id
}

output "login_server" {
  description = "URL del servidor de login del Container Registry"
  value       = azurerm_container_registry.this.login_server
}

output "admin_username" {
  description = "Nombre de usuario admin del Container Registry"
  value       = azurerm_container_registry.this.admin_username
  sensitive   = true
}

output "admin_password" {
  description = "Contraseña admin del Container Registry"
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
}