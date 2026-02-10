resource "azurerm_container_app" "this" {
  name                         = var.name
  resource_group_name          = var.rg_name
  container_app_environment_id = var.container_env_id
  revision_mode                = "Single"

  identity {
    type = "SystemAssigned"
  }

  registry {
    server   = var.acr_login_server
    identity = "System"
  }

  secret {
    name                  = var.secret_name
    key_vault_secret_id   = var.key_vault_secret_id
    identity              = "System"
  }

  ingress {
    external_enabled = true
    target_port      = var.ingress_target_port

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    init_container {
      name    = "init"
      image   = "alpine:3.19"
      command = ["sh", "-c", "echo Iniciando...; sleep 5"]
      cpu     = 0.25
      memory  = "0.5Gi"
    }

    container {
      name   = "api"
      image  = var.image
      cpu    = 0.5
      memory = "1Gi"

      env {
        name        = "MY_SECRET"
        secret_name = var.secret_name
      }
    }
  }
}
