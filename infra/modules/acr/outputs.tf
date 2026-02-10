output "id" {
  value = azurerm_container_registry.this.id
}

output "login_server" {
  value = azurerm_container_registry.this.login_server
}

output "name" {
  value = azurerm_container_registry.this.name
}

output "admin_username" {
  value = azurerm_container_registry.this.admin_username
}

output "admin_password" {
  value     = azurerm_container_registry.this.admin_password
  sensitive = true
}
