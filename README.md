# ☁️ Azure Enterprise Infrastructure with Terraform

> **Infrastructure Cloud sécurisée, modulaire et prête pour la production sur Microsoft Azure**, conçue selon les standards **Enterprise / DevOps / FinOps**.

[![Made by DigitalPro](https://img.shields.io/badge/Made%20by-MAHJOUBI-Portfolio)](https://abdessamadmahjoubidevops.github.io/portfolio/)


<p align="center">
  <img src="https://img.shields.io/badge/Terraform-1.10+-623CE4?style=for-the-badge&logo=terraform" />
  <img src="https://img.shields.io/badge/Microsoft_Azure-Enterprise-0078D4?style=for-the-badge&logo=microsoft-azure" />
  <img src="https://img.shields.io/badge/Infrastructure_as_Code-Best_Practices-success?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Security-Zero_Passwords-critical?style=for-the-badge" />
</p>

---

## 📌 Présentation

Ce projet déploie une **architecture Web 2‑tiers sécurisée** sur **Microsoft Azure**, entièrement automatisée avec **Terraform**, respectant les meilleures pratiques professionnelles :

- Sécurité by‑design
- Modularité & réutilisabilité
- Gouvernance Cloud
- FinOps & Tagging
- Prêt pour CI/CD & production

---

## ✨ Fonctionnalités Clés
### 🧩 Modularité
- Architecture Terraform **100 % modulaire**
- Modules réutilisables :
    - `network`
    - `compute`
---

### 🔐 Sécurité
- 🔑 Authentification **SSH uniquement**
- ❌ Aucun mot de passe stocké
- 🛡️ **NSG strictement configuré**
- 🔒 **Terraform Remote State**
- Azure Storage Account
- Verrouillage d’état (*State Locking*)

---








## 🏗️ Architecture Cloud

### 🔹 Vue d’ensemble

```mermaid
graph TD
    User((🌍 Internet User)) -->|HTTP :80| PIP[🌐 Public IP]

    subgraph Azure["☁️ Microsoft Azure"]
        subgraph VNet["🔐 Virtual Network"]
            subgraph PublicSubnet["🟦 Public Subnet"]
                PIP --> VM[🐧 Linux VM<br/>Nginx]
                NSG[🛡️ Network Security Group] -.-> VM
            end

            subgraph PrivateSubnet["🟩 Private Subnet"]
                DB[(🗄️ Future Database)]
            end
        end
    end











```

---

## 📂 Structure du Projet

```

├── modules/                  # Modules réutilisables (Network, Compute)
├── environments/             # Environnements (Dev, Prod...)
│   └── dev/
│       ├── main.tf           # Point d'entrée
│       ├── provider.tf       # Backend Azure Storage
│       └── terraform.tfvars  # Variables (Région, Projet...)
└── README.md                 # Documentation

```


## 🚀 Déploiement
### ✅ Pré‑requis
- Terraform ≥ 1.0
- Azure CLI installé
- Authentification Azure :

```bash
az login
git clone https://github.com/AbdessamadMAHJOUBIdevops/azure-terraform-enterprise-architecture.git
cd azure-enterprise-project/environments/dev
terraform init
terraform plan
terraform apply 

```

---



👤 Auteur
Abdessamad Mahjoubi - DevOps & Cloud Engineer
 
