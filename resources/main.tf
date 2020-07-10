##################################################################################
# VARIABLES
##################################################################################

locals {
  rg_integration_resources_name = "${var.naming_prefix}-${terraform.workspace}-shared-resources"
  rg_connectors_name = "${var.naming_prefix}-${terraform.workspace}-connectors"
  prefix_name           = "${var.naming_prefix}-${terraform.workspace}"
  integration_acct_name = "${local.prefix_name}-integration-account"
  sku                   = var.integration_acct_sku
}

##################################################################################
# PROVIDERS
##################################################################################

provider "azurerm" {
  version = "~> 2.15"
  environment = var.arm_environment
  features {}
}

##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_resource_group" "rg_integration_resources" {
  name = local.rg_integration_resources_name
  location = var.resource_location
}

resource "azurerm_resource_group" "rg_connectors" {
  name = local.rg_connectors_name
  location = var.resource_location
}

##################################################################################
# OUTPUT
##################################################################################

output "azure-resourcegroup-integration-resources" {
  value = azurerm_resource_group.rg_integration_resources.name
}

output "azure-resourcegroup-connectors" {
  value = azurerm_resource_group.rg_connectors.name
}