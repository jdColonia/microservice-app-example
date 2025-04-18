variable "name" {
  description = "Nombre de la Function App"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación de la Function App"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subnet para la Function App"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID del App Service Plan compartido"
  type        = string
}

variable "acr_login_server" {
  description = "URL del servidor de login del Container Registry"
  type        = string
}
