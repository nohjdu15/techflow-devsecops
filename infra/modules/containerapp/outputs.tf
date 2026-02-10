output "id" {
  value = azurerm_container_app.this.id
}

output "fqdn" {
  value = azurerm_container_app.this.latest_revision_fqdn
}

output "identity_principal_id" {
  value = azurerm_container_app.this.identity[0].principal_id
}
