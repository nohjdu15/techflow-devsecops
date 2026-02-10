output "resource_group_name" {
  value = module.resource_group.name
}

output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "container_app_fqdn" {
  value = module.container_app.fqdn
}
