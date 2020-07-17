#set cloud and log in

az cloud set --name AzureCloud #AzureChinaCloud|AzureGermanCloud|AzureUSGovernment
az login
#az account set --subscription="<azure subscription id>"

#variables needed to be set
$plan_file_name = "plan.tfplan"

#set location to where the script is being executed from
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Set-Location $dir

terraform init
terraform plan -out $plan_file_name
terraform apply $plan_file_name