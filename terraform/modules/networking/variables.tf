variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación de los recursos"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
}

variable "address_space" {
  description = "Espacio de direcciones para la VNet"
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "Prefijos de subredes"
  type        = map(string)
}
