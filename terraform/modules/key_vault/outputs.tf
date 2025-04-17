output "key_vault_id" {
  description = "ID del Key Vault"
  value       = azurerm_key_vault.this.id
}

output "key_vault_uri" {
  description = "URI del Key Vault"
  value       = azurerm_key_vault.this.vault_uri
}
