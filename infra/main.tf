data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = false
  numeric = true
  special = false
}

locals {
  suffix          = random_string.suffix.result
  rg_name         = var.rg_name
  kv_name         = "${var.prefix}-kv-${local.suffix}"
  acr_name        = "${var.prefix}${local.suffix}"
  env_name        = "${var.prefix}-env-${local.suffix}"
  app_name        = "${var.prefix}-app-${local.suffix}"
  job_name        = "${var.prefix}-job-${local.suffix}"
  app_image       = "${module.acr.login_server}/${var.app_image_name}:${var.app_image_tag}"
  job_image       = "${module.acr.login_server}/${var.job_image_name}:${var.job_image_tag}"
}

module "resource_group" {
  source   = "./modules/resource-group"
  name     = local.rg_name
  location = var.location
}

module "key_vault" {
  source    = "./modules/key-vault"
  name      = local.kv_name
  location  = var.location
  rg_name   = module.resource_group.name
  tenant_id = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_secret" "app" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = module.key_vault.id
}

module "acr" {
  source   = "./modules/acr"
  name     = local.acr_name
  rg_name  = module.resource_group.name
  location = var.location
}

module "containerapps_env" {
  source   = "./modules/containerapps-env"
  name     = local.env_name
  rg_name  = module.resource_group.name
  location = var.location
}

module "container_app" {
  source                 = "./modules/containerapp"
  name                   = local.app_name
  rg_name                = module.resource_group.name
  location               = var.location
  container_env_id       = module.containerapps_env.id
  image                  = local.app_image
  acr_login_server       = module.acr.login_server
  key_vault_secret_id    = azurerm_key_vault_secret.app.versionless_id
  secret_name            = var.secret_name
  ingress_target_port    = 8000
}

module "container_app_job" {
  source           = "./modules/containerapp-job"
  name             = local.job_name
  rg_name          = module.resource_group.name
  location         = var.location
  container_env_id = module.containerapps_env.id
  image            = local.job_image
  acr_login_server = module.acr.login_server
  cron_expression  = var.cron_expression
}

resource "azurerm_role_assignment" "acr_pull_app" {
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.container_app.identity_principal_id
}

resource "azurerm_role_assignment" "acr_pull_job" {
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.container_app_job.identity_principal_id
}

resource "azurerm_key_vault_access_policy" "app" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.container_app.identity_principal_id

  secret_permissions = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "terraform_sp" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = ["Get", "List", "Set"]
}
