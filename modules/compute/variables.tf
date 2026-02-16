

variable "resource_group_name" {
    type = string
}


variable "location" {

    type = string
}


variable "subnet_id" {

    description = "L'Id du subnet où placer la carte réseaux"
    type = string
}

variable "vm_name" {
    description = "Le Nom du VM"
    type = string
    default = "vm-web-01"
}

variable "ssh_public_key_path" {
  description = "Chemin vers la clé publique SSH"
  type        = string
  default     = "~/.ssh/azure_project_key.pub"
  
}

variable "tags" {
    description = "Tags à appliquer aux ressources"
    type = map(string)
    default = {}
  
}



