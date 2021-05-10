<#
.SYNOPSIS
    Swaps Azure Web App Slots based on input names

.DESCRIPTION
    Swaps Azure Web App Slots based on input names

.PARAMETER subscriptionId
    Subscription Id of App Service

.PARAMETER appServiceResourceGroup
    Resource Group name where app service exists

.PARAMETER appServiceName
    Name of App Service

.PARAMETER sourceSlot
    Name of Source slot to swap

.PARAMETER destinationSlot
    Name of destination slot to swap

.EXAMPLE
    .\Swap-AppServiceSlots.ps1 -appServiceName  awa-weu-pmp-be-001 -appServiceResourceGroup lz1-pmp-rg -subscriptionId 95ce893c-179b-44b7-a47a-45645646 -sourceSlot staging -destinationSlot production

.NOTES
	Version      : 0.0.0.1
	Last Updated : 2021-05-04
	Author       : Will Jones
	Keywords     : App Service, Slots
	Open Issues  :

#>

Param(
    [Parameter(Mandatory = $true)]
    [string]
    $subscriptionId,

    [Parameter(Mandatory = $true)]
    [string]
    $appServiceResourceGroup,  
  
    [Parameter(Mandatory = $true)]
    [string]
    $appServiceName,
   
    [Parameter(Mandatory = $true)]
    [string]
    $sourceSlot,

    [Parameter(Mandatory = $true)]
    [string]
    $destinationSlot

)
write-host "Swap App Service Slot"
Install-Module Az -Scope CurrentUser -Force
Select-AzSubscription -Subscription $subscriptionId

Swap-AzWebAppSlot -SourceSlotName $sourceSlot -DestinationSlotName $destinationSlot -ResourceGroupName $appServiceResourceGroup -Name $appServiceName   



