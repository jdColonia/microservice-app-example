variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación de los App Services"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID del App Service Plan compartido"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subnet para los App Services"
  type        = string
}

variable "acr_login_server" {
  description = "URL del servidor de login del Container Registry"
  type        = string
}

variable "microservices" {
  description = "Configuración de microservicios"
  type = map(object({
    image_name     = string
    container_port = number
    cpu            = string
    memory         = string
    env_vars       = map(string)
  }))
}

variable "key_vault_id" {
  description = "ID del Key Vault"
  type        = string
}
