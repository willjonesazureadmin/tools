<#
.SYNOPSIS
    Generate SAS Tokens for provided storage account details
    
.PARAMETER storageAccountResourceGroupName
    Resource group that contains the storage account
.PARAMETER storageAccountName
    The name of the storage account to use
.PARAMETER storageService
    The storage service to generate a SAS for e.g. Blob, File, None, Queue, Table
.PARAMETER validForDays
    Number of days that token should be valid for

    
.EXAMPLE
  .\Generate-SASToken.ps1 -storageAccountResourceGroupName Automation -storageAccountName azureupdatestbl -storageService File -validForDays 1   
  
.NOTES
	Version      : 1.0.0.0
	Last Updated : 2021-07-08
	Author       : Will Jones
	Open Issues  :
#>


Param(   
    [Parameter(Mandatory = $true)]
    [string]
    $storageAccountResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]
    $storageAccountName,

    [Parameter(Mandatory = $true)]
    [string]
    $storageService,

    [Parameter(Mandatory = $true)]
    [int]
    $validForDays
)

$sakey = Get-AzStorageAccountKey -ResourceGroupName $storageAccountResourceGroupName -Name $storageAccountName
$sa = Get-AzStorageAccount -ResourceGroupName $storageAccountResourceGroupName -Name $storageAccountName
$context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $sakey[0].Value
$token = New-AzStorageAccountSASToken -ResourceType container -Service $storageService -Context $context -ExpiryTime (Get-Date).AddDays($validForDays)


Write-Host "SAS Tokens are:"
Write-Host  $($endpoint.Blob+$token)
Write-Host $($endpoint.Dfs+$token)
Write-Host  $($endpoint.File+$token)
Write-Host $($endpoint.Queue+$token)
Write-Host $($endpoint.Table+$token)
Write-Host $($endpoint.Web+$token)

