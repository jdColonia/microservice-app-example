output "vnet_id" {
  description = "ID de la red virtual"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Nombre de la red virtual"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "IDs de las subredes"
  value = {
    frontend    = azurerm_subnet.frontend.id
    integration = azurerm_subnet.integration.id
    application = azurerm_subnet.application.id
    security    = azurerm_subnet.security.id
  }
}