# On définit nos tags communs ICI, une seule fois.
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = "Abdessamad"
    ManagedBy   = "Terraform"
    CostCenter  = "IT-DevOps-001"
  }
}








resource "azurerm_resource_group" "main" {
  name = "rg-${var.project_name}-${var.environment}-${var.location}"
  location = var.location
  tags = local.common_tags
}

module "network" {
    # Source : Où est le code du module ?
    source = "../../modules/network"

    #  Inputs : On passe les valeurs
  # Note : On utilise resource_group.main.name pour créer une dépendance explicite

  resource_group_name = azurerm_resource_group.main.name
  location = var.location


  # On peut surcharger le nom si on veut, ou laisser le défaut
  vnet_name = "vnet-${var.project_name}-${var.environment}"
  tags = local.common_tags
  
}


module "compute" {

    source = "../../modules/compute"

    # On passe les infos de base
    resource_group_name = azurerm_resource_group.main.name
    location = var.location

    # MAGIE TERRAFORM : On connecte la sortie du module Network à l'entrée du module Compute
    subnet_id = module.network.public_subnet_id

    # Optionnel : On peut surcharger le nom
    vm_name = "vm-portfolio-dev"
    tags = local.common_tags
  
}

# On veut afficher l'IP dans le terminal à la fin
output "web_server_ip" {
  value = module.compute.public_ip_address
}

output "app_url" {
  value = "http://${module.compute.public_ip_address}"
  description = "L'URL pour accéder à l'application"
}


