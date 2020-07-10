#############################################################################
# VARIABLES
#############################################################################
variable "arm_subscription_id" {}
#variable "arm_principal" {}
#variable "arm_password" {}
variable "tenant_id" {}

variable "location" {
  type    = string
}

variable "naming_prefix" {
  type    = string
}

variable "environment" {
  type   = string
}

variable "arm_environment" {
  type   = string
}
##################################################################################
# LOCALS
##################################################################################

locals {
  resource_group_name = "${var.naming_prefix}-${var.environment}-devops"
}

##################################################################################
# PROVIDERS
##################################################################################

provider "azurerm" {
  version = "~> 2.15"
  subscription_id = var.arm_subscription_id
  #client_id       = var.arm_principal
  #client_secret   = var.arm_password
  tenant_id       = var.tenant_id
  environment     = var.arm_environment
  features {}
}

##################################################################################
# RESOURCES
##################################################################################
resource "random_integer" "sa_num" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "setup" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.naming_prefix)}${lower(var.environment)}devops${random_integer.sa_num.result}"
  resource_group_name      = azurerm_resource_group.setup.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "ct" {
  name                 = "terraform-state"
  storage_account_name = azurerm_storage_account.sa.name
}

data "azurerm_storage_account_sas" "state" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "17520h") #token expires in 2 years

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
  }
}

#############################################################################
# PROVISIONERS
#############################################################################

#render storage and token information into a text file
resource "null_resource" "post-config" {

  depends_on = [azurerm_storage_container.ct]

  provisioner "local-exec" {
    command = <<EOT
"storage_account_name = `"${azurerm_storage_account.sa.name}`"" | Out-File -FilePath .\backend-config.txt
Add-Content .\backend-config.txt "container_name = `"terraform-state`""
Add-Content .\backend-config.txt "key = `"terraform.tfstate`""
Add-Content .\backend-config.txt "sas_token = `"${data.azurerm_storage_account_sas.state.sas}`""
EOT
    interpreter = ["PowerShell", "-Command"]
  }
}

##################################################################################
# OUTPUT
##################################################################################

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "resource_group_name" {
  value = azurerm_resource_group.setup.name
}