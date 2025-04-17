variable "subscription_id" {
  description = "Subscripción de azure"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "microservices-app"
}

variable "location" {
  description = "Región de Azure donde se desplegará la infraestructura"
  type        = string
  default     = "West Europe"
}

# Variables para redes
variable "address_space" {
  description = "Espacio de direcciones para la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Prefijos de subredes"
  type        = map(string)
  default = {
    frontend    = "10.0.1.0/24"
    integration = "10.0.2.0/24"
    application = "10.0.3.0/24"
    data        = "10.0.4.0/24"
    security    = "10.0.5.0/24"
  }
}

# Variables para Container Registry
variable "acr_sku" {
  description = "SKU para Azure Container Registry"
  type        = string
  default     = "Standard"
}

# Variables para microservicios
variable "microservices" {
  description = "Configuración de microservicios"
  type = map(object({
    image_name     = string
    container_port = number
    cpu            = string
    memory         = string
    env_vars       = map(string)
  }))
  default = {
    "auth-api" = {
      image_name     = "auth-api"
      container_port = 8000
      cpu            = "0.5"
      memory         = "1Gi"
      env_vars = {
        JWT_SECRET        = "PRFT"
        AUTH_API_PORT     = "8000"
        USERS_API_ADDRESS = "http://users-api:8080"
      }
    },
    "users-api" = {
      image_name     = "users-api"
      container_port = 8080
      cpu            = "1.0"
      memory         = "2Gi"
      env_vars = {
        JWT_SECRET             = "PRFT"
        SERVER_PORT            = "8080"
        SPRING_PROFILES_ACTIVE = "default"
      }
    },
    "todos-api" = {
      image_name     = "todos-api"
      container_port = 3000
      cpu            = "0.5"
      memory         = "1Gi"
      env_vars = {
        JWT_SECRET    = "PRFT"
        TODO_API_PORT = "3000"
        REDIS_HOST    = "redis"
        REDIS_PORT    = "6379"
        REDIS_CHANNEL = "log_channel"
        USERS_API_URL = "http://users-api:8080"
      }
    }
  }
}

# Variables para API Management
variable "apim_sku" {
  description = "SKU para API Management"
  type        = string
  default     = "Developer"
}

variable "apim_capacity" {
  description = "Capacidad para API Management"
  type        = number
  default     = 1
}

# Variables para Static Web App
variable "static_web_app_sku" {
  description = "SKU para Static Web App"
  type        = string
  default     = "Free"
}