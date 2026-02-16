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