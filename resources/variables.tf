##################################################################################
# VARIABLES
##################################################################################
variable "naming_prefix" {
  type    = string
  default = "dc"
}

variable "arm_environment" {
  type    = string
  default = "public"
}

variable "resource_location" {
  type    = string
  default = "eastus2"
}

variable "integration_acct_sku" {
  type    = string
  default = "Free"
}

variable "custom_api_connector_costcenter_service_url" {
  type    = string
}