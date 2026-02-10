variable "name" {
  type        = string
  description = "ACR name (global unique)"
}

variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sku" {
  type        = string
  description = "ACR SKU"
  default     = "Basic"
}
