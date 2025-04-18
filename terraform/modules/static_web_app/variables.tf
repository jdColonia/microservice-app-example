variable "name" {
  description = "Nombre de la Static Web App"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación de la Static Web App"
  type        = string
}

variable "sku" {
  description = "SKU de la Static Web App"
  type        = string
  default     = "Free"
}
