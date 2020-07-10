##################################################################################
# RESOURCES
##################################################################################

resource "azurerm_template_deployment" "custom_api_connectors" {
  name                = "${local.prefix_name}-custom-api-connectors-deployment"
  resource_group_name =  azurerm_resource_group.rg_connectors.name
  template_body       = file("../arm/connectors/custom-connectors.azrm.json")
  deployment_mode     = "Incremental"
  parameters_body     = <<EOF
  {
   "custom_api_connector_name": {
            "value": "${local.prefix_name}-custom-connectors-decodedclouds"
        },
   "custom_api_connector_service_url": {
            "value": "${var.custom_api_connector_service_url}"
        },
   "custom_api_connector_location": {
            "value": "${var.resource_location}"
        },
   "custom_api_connector_openapi": {
            "value": ${file("../arm/connectors/openapi/dc-swagger-sample.json")}
        }
  }
  EOF
}

