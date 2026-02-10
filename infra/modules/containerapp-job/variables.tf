variable "name" {
  type        = string
  description = "Container App Job name"
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

variable "cron_expression" {
  type        = string
  description = "Cron schedule"
}
