
variable "resource_group_name" {

    description = "Le nom du RG existant"
    type = string
  
}


variable "location" {

    description = "La region azure"
    type = string
  
}

variable "vnet_name" {
    description = "Nom du Vertual Network"
    type = string
    default = "vnet-main"
  
}

variable "adress_space" {
    description = "L'espace d'adressage global (CIDR)"
    type = list(string)
    default = ["10.0.0.0/16"]
  
}

variable "tags" {
    description = "Tags à appliquer aux ressources"
    type = map(string)
    default = {}
  
}