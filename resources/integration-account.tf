##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_logic_app_integration_account" "integration_acct" {
  name                = local.integration_acct_name
  resource_group_name = azurerm_resource_group.rg_integration_resources.name
  location            = azurerm_resource_group.rg_integration_resources.location
  sku_name            = local.sku
}

resource "azurerm_template_deployment" "integration_acct_components" {
  name                = "${local.prefix_name}-integration-account-deployment"
  resource_group_name =  azurerm_resource_group.rg_integration_resources.name

  parameters = {
    integrationAccount_name = azurerm_logic_app_integration_account.integration_acct.name
    canonical_to_department_script = file("../arm/integration-account/maps/canonical-to-department.liquid")
  }

  template_body       = file("../arm/integration-account/integration-account.azrm.json")
  deployment_mode     = "Incremental"

  depends_on = [
    azurerm_logic_app_integration_account.integration_acct
  ]
}

