# ☁️ Azure Enterprise Infrastructure with Terraform

Ce projet déploie une infrastructure Web sécurisée, modulaire et conforme aux standards d'entreprise sur Microsoft Azure.

![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?style=for-the-badge&logo=terraform)
![Azure](https://img.shields.io/badge/Azure-Pro-0078D4?style=for-the-badge&logo=microsoft-azure)

## 🏗️ Architecture

Le projet déploie une architecture 2-tiers classique :

```mermaid
graph TD
    User((Internet User)) -->|HTTP :80| LB[Public IP]
    subgraph Azure Cloud
        subgraph VNet
            subgraph Public Subnet
                LB --> VM[Linux VM + Nginx]
                NSG[NSG Firewall] -.-> VM
            end
            subgraph Private Subnet
                DB[(Future Database)]
            end
        end
    end


    ✨ Fonctionnalités Clés
Modularité : Code découpé en modules réutilisables (network, compute).

Sécurité :

Pas de mots de passe (Clés SSH uniquement).

État Terraform stocké à distance (Azure Storage Account) avec verrouillage.

NSG (Firewall) configuré strictement.

Automatisation : Script de démarrage robuste (anti-race-condition) pour l'installation de Nginx.

Gouvernance : Stratégie de Tagging centralisée pour le FinOps.


🚀 Comment déployer
Pré-requis
Terraform installé.

Azure CLI installé et authentifié (az login).

Étapes
Cloner le repo :

Bash
git clone [https://github.com/AbdessamadMAHJOUBIdevops/azure-terraform-enterprise-architecture.git)
cd azure-enterprise-project/environments/dev
Initialiser Terraform (Téléchargement des providers & Backend) :

Bash
terraform init
Vérifier le plan :

Bash
terraform plan
Appliquer :

Bash
terraform apply
📂 Structure du Projet
Plaintext
├── modules/                  # Modules réutilisables (Network, Compute)
├── environments/             # Environnements (Dev, Prod...)
│   └── dev/
│       ├── main.tf           # Point d'entrée
│       ├── provider.tf       # Backend Azure Storage
│       └── terraform.tfvars  # Variables (Région, Projet...)
└── README.md                 # Documentation
👤 Auteur
Abdessamad Mahjoubi - DevOps & Cloud Engineer