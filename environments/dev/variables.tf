
variable "project_name" {
    description = "myApp"
    type = string
}

variable "environment" {
    description = "L'environnement (dev, staging, prod)"
    type = string
  
}

variable "location" {

    description = "Localisation Azure francecentral"
    type = string
    default = "francecentral"
  
}