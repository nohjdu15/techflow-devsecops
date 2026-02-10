resource "azurerm_container_app_job" "this" {
  name                         = var.name
  resource_group_name          = var.rg_name
  location                     = var.location
  container_app_environment_id = var.container_env_id
  trigger_type                 = "Schedule"

  identity {
    type = "SystemAssigned"
  }

  registry {
    server   = var.acr_login_server
    identity = "system"
  }

  schedule_trigger_config {
    cron_expression = var.cron_expression
  }

  template {
    container {
      name   = "job"
      image  = var.image
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}
