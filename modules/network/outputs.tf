
output "vnet_id" {

    description = "L'ID du vnet crée"
    value = azurerm_virtual_network.main.id
}


output "public_subnet_id" {

    description = "l'ID du subnet public (pour y mettre des VMs)"
    value = azurerm_subnet.public.id  
}


output "private_subnet_id" {
    description = "L'ID du subnet privé"
    value = azurerm_subnet.private.id
  
}