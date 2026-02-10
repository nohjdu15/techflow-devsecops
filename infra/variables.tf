variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "rg_name" {
  type        = string
  description = "Existing resource group name"
  default     = "rg-techflow-dev"
}

variable "prefix" {
  type        = string
  description = "Prefix for resource names (alphanumeric, lowercase)"
  default     = "techflow"
}

variable "secret_name" {
  type        = string
  description = "Key Vault secret name"
  default     = "my-secret"
}

variable "secret_value" {
  type        = string
  description = "Key Vault secret value"
  sensitive   = true
}

variable "app_image_name" {
  type        = string
  description = "Container image name for the API"
  default     = "techflow-app"
}

variable "job_image_name" {
  type        = string
  description = "Container image name for the job"
  default     = "techflow-job"
}

variable "app_image_tag" {
  type        = string
  description = "Container image tag for the API"
  default     = "latest"
}

variable "job_image_tag" {
  type        = string
  description = "Container image tag for the job"
  default     = "latest"
}

variable "cron_expression" {
  type        = string
  description = "Cron schedule for the job"
  default     = "0 */6 * * *"
}
