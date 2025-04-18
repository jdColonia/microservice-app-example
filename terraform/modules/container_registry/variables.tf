variable "name" {
  description = "Nombre del Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación del Container Registry"
  type        = string
}

variable "sku" {
  description = "SKU del Container Registry"
  type        = string
  default     = "Standard"
}
