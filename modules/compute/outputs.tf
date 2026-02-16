
output "public_ip_address" {

    description = "L'adress IP publique de la VM"
    value = azurerm_public_ip.main.ip_address
  
}