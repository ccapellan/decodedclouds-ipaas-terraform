# Introduction 
This repository contains the source code to get started with Terraform and Azure iPaaS components.  It includes generic patterns to bring up various Azure components used in iPaaS architectures.  Right now, this includes:

1. Setting up remote state with Azure
2. Bringing up an Azure Logic App Integration Account
3. Adding Maps to the Integration Account
4. Creating Custom API Connectors

# Getting Started

## Installation on Machine

These are my recommendations on getting set up to properly use these scripts.  This code is meant to run on a Windows computer leveraging PowerShell.

1. Download [Terraform](https://www.terraform.io/downloads.html) and add executable to path environment variable
2. Install [Visual Studio Code](https://code.visualstudio.com/download)
3. Install VS Code Terraform extension by HashiCorp
4. Install [Git for Windows](https://git-scm.com/download/win)
5. Allow PowerShell script execution on local machine

`Set-ExecutionPolicy -ExecutionPolicy Bypass`

6. Install latest version of [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
7. An Azure subscription for which you have at least Contributor access

# Build and Test

This code uses the remote state management strategy, where the Terraform state file is hosted in an Azure Storage container.  Follow the steps below to create an Azure storage account and container to use to host Terraform's state file.

1. Clone this repo
2. Remove the .example extension to the file **remote-state-prep/terraform.tfvars.example**, and fill in the proper values in the file.  
3. This example authenticates using [Azure CLI](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html).  To use the service principal option, follow step 4. If not, proceed to step 5.


3. As an alternative, [Set up a service principal to authenticate with Azure](https://www.terraform.io/docs/provideers/azurerm/guides/service_principal_client_secret.html).  Uncomment the principal and password variables in the following files:

**remote-state-prep/terraform.tfvars**
**remote-state-prep/main.tf** (lines 5-6 and 39-40)

4. Run the PowerShell script **create-storage.ps1**.  This will create a file called **backend-config.txt** in the same directory which contains the values needed to configure Azure DevOps.
