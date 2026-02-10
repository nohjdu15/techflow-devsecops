variable "name" {
  type        = string
  description = "Container App name"
}

variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "container_env_id" {
  type        = string
  description = "Container Apps environment ID"
}

variable "image" {
  type        = string
  description = "Container image"
}

variable "acr_login_server" {
  type        = string
  description = "ACR login server"
}

variable "key_vault_secret_id" {
  type        = string
  description = "Key Vault secret ID"
}

variable "secret_name" {
  type        = string
  description = "Secret name to mount as env var"
}

variable "ingress_target_port" {
  type        = number
  description = "Ingress port"
}
