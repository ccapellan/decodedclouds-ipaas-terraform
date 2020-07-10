# Introduction 
This repository contains the source code to get started with Terraform and Azure iPaaS components.  It includes generic patterns to bring up various Azure components used in iPaaS architectures.  Right now, this includes:

1. Setting up remote state with Azure
2. Bringing up an Azure Logic App Integration Account
    a. adding Maps to the Integration Account
3. Creating Custom API Connectors

# Getting Started

## Installation on Machine

These are my recommendations on getting set up to properly use these scripts.

1. Download [Terraform](https://www.terraform.io/downloads.html) and add executable to path environment variable
2. Install Visual Studio Code
3. Install VS Code Terraform extension by HashiCorp
4. Install Git for Windows
5. Allow PowerShell script execution on local machine
6. Install latest version of Azure CLI

`Set-ExecutionPolicy -ExecutionPolicy Bypass`

6. An Azure subscription for which you have at least Contributor access

# Build and Test

This code uses the remote state management strategy, where the Terraform state file is hosted in an Azure Storage container.  Follow the steps below to create an Azure storage account and container to use to host Terraform's state file.

1. Clone this repo
2. Create a file called **terraform.tfvars** in the **remote-state-prep** folder with the following variables (values will be obtained in next step)

`arm_subscription_id = "(value)"`

`arm_principal = "(value)"`

`arm_password = "(value)"`

`arm_environment = "(value)"`

`tenant_id = "(value)"`

`environment = "(prefix that defines env; ex: Dev)"` 

`location = "eastus2"`

`naming_prefix = "dc"`

3. [Set up a service principal to authenticate with Azure](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html).  Note to update the file created in the previous step with the values obtained.

4. Run the PowerShell script **create-storage.ps1**.  This will create a file called **backend-config.txt** in the same directory which contains the values needed to configure Azure DevOps.
