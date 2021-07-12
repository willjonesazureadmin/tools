Param(   
    [Parameter(Mandatory = $true)]
    [string]
    $resourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]
    $vmName,

    [Parameter(Mandatory = $true)]
    [string]
    $cuaId,

    [Parameter(Mandatory = $false)]
    [string]
    $resourceTypeToRemoveFromTemplate = "extension"
)
$ErrorActionPreference = "stop"

$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName
Write-Host "Got VM Resource" $vm.Name

$export = Export-AzResourceGroup -ResourceGroupName $resourceGroupName -Resource $vm.id -Force -IncludeParameterDefaultValue
Write-Host "Got Resource ARM Definition saved locally" $export.Path

Write-Host "Modifying Template"
$template = Get-Content -Path $export.Path  | ConvertFrom-Json
$ACRResource = Get-Content -Path .\ACRResource.json | ConvertFrom-Json 
$ACRResource.Name = "pid-" + $cuaId
$template.resources += $ACRResource
$template.resources = ($template.resources | Where { $_.type -notlike "*$($resourceTypeToRemoveFromTemplate)*" })
$parametersToRemove = ($template.parameters.psobject.properties | where-object { $_.Name -like "*$($resourceTypeToRemoveFromTemplate)*" }).Name
foreach($p in $parametersToRemove)
{
$template.parameters.psobject.Properties.Remove($p)
}
$raw = ($template | ConvertTo-Json -Depth 50).ToString().Replace("\u0027","'") 
$raw | Out-File -FilePath "$($vm.Name).json" -Force  
Write-Host "Template Saved"

Write-Host "Performing What If"
$result = Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName $resourceGroupName -TemplateFile "$($vm.Name).json" -Name "$($vm.Name)-ACR-CUA-ID" -ResultFormat FullResourcePayloads 
if ($result.Changes.ChangeType -contains "Modify") 
{ 
    write-host "Modification detected - terminating" -ForegroundColor Red
    $result.Changes
}
else
{
    Write-Host "Performing deployment" -ForegroundColor Green
    New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile "$($vm.Name).json" -Name "$($vm.Name)-ACR-CUA-ID"
}





