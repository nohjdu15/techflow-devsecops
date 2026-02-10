terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}

  # El SP solo tiene permisos en el RG, no en la suscripcion.
  # Evitamos que Terraform intente registrar proveedores a nivel suscripcion.
  skip_provider_registration = true
}
