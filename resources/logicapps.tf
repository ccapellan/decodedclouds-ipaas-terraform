##################################################################################
# Variables
##################################################################################

locals {
  logic_app_name = "${local.prefix_name}-example-logicapp"
}

##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_logic_app_workflow" "exampl_logic_app" {
  name                = local.logic_app_name
  resource_group_name = azurerm_resource_group.rg_logic_apps.name
  location            = azurerm_resource_group.rg_logic_apps.location
}

resource "azurerm_template_deployment" "example_logic_apps" {
  name                = "${local.prefix_name}-example-logic-apps-deployment"
  resource_group_name =  azurerm_resource_group.rg_logic_apps.name

  parameters = {
    workflows_CheckTwitter_name = local.logic_app_name
    connections_cognitiveservicestextanalytics_externalid = "/subscriptions/ab29ab57-cf1d-4e7e-aa21-6ff49fea6e7e/resourceGroups/dc-sandbox-LogicApps/providers/Microsoft.Web/connections/cognitiveservicestextanalytics"
    connections_sendgrid_externalid = "/subscriptions/ab29ab57-cf1d-4e7e-aa21-6ff49fea6e7e/resourceGroups/dc-sandbox-LogicApps/providers/Microsoft.Web/connections/sendgrid"
    connections_twitter_externalid = "/subscriptions/ab29ab57-cf1d-4e7e-aa21-6ff49fea6e7e/resourceGroups/dc-sandbox-LogicApps/providers/Microsoft.Web/connections/twitter"
    resouce_location = azurerm_resource_group.rg_logic_apps.location
    connections_cognitiveservicestextanalytics_name = "cognitiveservicestextanalytics"
    connections_sendgrid_name = "sendgrid"
    connections_twitter_name = "twitter"
  }

  template_body       = file("../arm/logic-apps/logic-app.azrm.json")
  deployment_mode     = "Incremental"
  depends_on = [
    azurerm_logic_app_workflow.exampl_logic_app
  ]
}