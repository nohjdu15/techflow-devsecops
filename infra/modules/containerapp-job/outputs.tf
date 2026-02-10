output "id" {
  value = azurerm_container_app_job.this.id
}

output "identity_principal_id" {
  value = azurerm_container_app_job.this.identity[0].principal_id
}
