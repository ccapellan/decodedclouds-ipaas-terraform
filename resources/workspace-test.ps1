[CmdletBinding()]
param(
 $Environment
)

$env = $Environment

if((terraform workspace list) -match $env){
    Write-Host 'selecting workspace' $env 
    terraform workspace select $env
}
else{
    Write-Host 'creating workspace ' $env 
    terraform workspace new $env 
}