##################################################################################
# VARIABLES
##################################################################################

locals {
  prefix_name = "${var.resources_naming_prefix}-${terraform.workspace}"
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
  name = "${local.prefix_name}-shared-resources"
  location = var.resource_location
}

resource "azurerm_resource_group" "rg_connectors" {
  name = "${local.prefix_name}-connectors"
  location = var.resource_location
}

resource "azurerm_resource_group" "rg_logic_apps" {
  name = "${local.prefix_name}-logic-apps"
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

output "azure-resourcegroup-logic-apps" {
  value = azurerm_resource_group.rg_logic_apps.name
}