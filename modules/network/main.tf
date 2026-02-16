
# Creation du Vnet
resource "azurerm_virtual_network" "main" {

  name = var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.adress_space
  tags = var.tags
  
}

# Création du Subnet PUBLIC (Web) 
resource "azurerm_subnet" "public" {

  name = "subnet-public"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = ["10.0.1.0/24"]
   
}


# Création du Subnet PRIVÉ (Database/Backend)
resource "azurerm_subnet" "private" {

  name = "subnet-private"
  resource_group_name =  var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = ["10.0.2.0/24"]
  
}

# Sécurité : Création d'un NSG (Firewall) pour le Public

resource "azurerm_network_security_group" "public_nsg" {
  name = "nsg-public-access"
  location = var.location
  resource_group_name = var.resource_group_name 
  tags = var.tags

  # Règle : Autoriser SSH (Port 22) - ATTENTION : En prod, restreindre à mon  IP ! c'est important abdel

  security_rule  {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Règle : Autoriser HTTP (Port 80)
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
   


}


# Association : On colle le NSG sur le Subnet Public

resource "azurerm_subnet_network_security_group_association" "public-assoc" {

  subnet_id = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
  
}