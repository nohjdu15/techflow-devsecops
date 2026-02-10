variable "name" {
  type        = string
  description = "Key Vault name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "sku_name" {
  type        = string
  description = "Key Vault SKU"
  default     = "standard"
}
