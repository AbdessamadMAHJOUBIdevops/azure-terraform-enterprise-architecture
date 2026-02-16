
# 1. L'Adresse IP Publique
resource "azurerm_public_ip" "main" {
  resource_group_name = var.resource_group_name
  name = "pip-${var.vm_name}"
  location = var.location
  allocation_method = "Static" # IP Fixe (Standard en prod)
  sku = "Standard"
  tags = var.tags
  
}


# 2. La Carte Réseau (Le câble Ethernet virtuel)
resource "azurerm_network_interface" "main" {
  name = "nic-${var.vm_name}"
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags

  ip_configuration {
    name = "internal"
    subnet_id = var.subnet_id  # Connecté au Subnet Public
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main.id # On attache l'IP publique ici

  }
  
}


# 3. La VM Linux (Le Serveur)
resource "azurerm_linux_virtual_machine" "main" {
    name = var.vm_name
    resource_group_name = var.resource_group_name
    location = var.location
    size = "Standard_B1s" # La moins chère pour les labs (mais suffisante)
    admin_username = "adminuser"
  tags = var.tags

 # On attache la carte réseau créée juste au-dessus
 network_interface_ids = [
     azurerm_network_interface.main.id,
 ]

 # Authentification SSH (Sécurité Enterprise)
 admin_ssh_key {
   username = "adminuser"
   public_key = file(var.ssh_public_key_path)

 }

 os_disk {
   caching = "ReadWrite"
   storage_account_type = "Standard_LRS"  # Moins cher
 }

 source_image_reference {
   publisher = "Canonical"
   offer = "0001-com-ubuntu-server-jammy" # Ubuntu 22.04 LTS
   sku = "22_04-lts"
   version = "latest"
 }


  # Le script de démarrage (Bootstrapping)
  # Installe Nginx et crée une page d'accueil personnalisée

  # On ajoute un sleep pour éviter le conflit avec les updates automatiques d'Ubuntu
  custom_data = base64encode(<<-EOF
              #!/bin/bash
              
              # 1. Redirection des logs (Standard DevOps pour le debug)
              exec > /var/log/user-data.log 2>&1
              echo "Début du script de provisionning..."

              # 2. La boucle anti-conflit : Tant que 'apt' est verrouillé, on attend
              # fuser vérifie si un processus utilise les fichiers de lock
              while fuser /var/lib/dpkg/lock >/dev/null 2>&1 || fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
                 echo "En attente de la fin des mises à jour automatiques Ubuntu..."
                 sleep 5
              done

              echo "Verrous libérés. Démarrage de l'installation."

              # 3. Installation sécurisée
              # DEBIAN_FRONTEND=noninteractive empêche les popups bleus qui bloquent le script
              export DEBIAN_FRONTEND=noninteractive
              
              apt-get update -y
              apt-get install -y nginx

              # 4. Configuration
              systemctl start nginx
              systemctl enable nginx
              
              echo "<h1>Deployed via Terraform (Fully Automated) by Abdessamad 🚀</h1>" > /var/www/html/index.html
              
              echo "Fin du script avec succès."
              EOF
  )




  
}