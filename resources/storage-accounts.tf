##################################################################################
# Variables
##################################################################################

locals {
  storage_account_name = "${var.resources_naming_prefix}${terraform.workspace}storageaccount"
}

##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_storage_account" "storage_acct" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.rg_integration_resources.name
  location                 = azurerm_resource_group.rg_integration_resources.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  allow_blob_public_access = false
}

resource "azurerm_storage_container" "example" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.storage_acct.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "example" {
  name                 = "sharename"
  storage_account_name = azurerm_storage_account.storage_acct.name
  quota                = 5120
}