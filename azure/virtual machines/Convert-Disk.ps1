<#
.SYNOPSIS
    Converts all VM disks to selected SKU

.DESCRIPTION
    Stops associated VM, amends disk SKU for all attached disks and then powers on the VM

.PARAMETER subscriptionId
    Subscription Id where the VM exists

.PARAMETER resourceGroupName
    Resource Group name where the VM exists

.PARAMETER vmName
    Name of the VM

.PARAMETER storageType
    The type of disk to convert to


.NOTES
	Version      : 1.0.0.0
	Last Updated : 2021-05-10
	Author       : Will Jones
	Keywords     : Azure DevOps, Disks, VM
	Open Issues  :

#>

Param(   
    [Parameter(Mandatory = $true)]
    [string]
    $subscriptionId,

    [Parameter(Mandatory = $true)]
    [string]
    $resourceGroupName,
  

    [Parameter(Mandatory = $true)]
    [string]
    $vmName,

    [Parameter(Mandatory = $true)]
    [string]
    $storageType 
    
)

#Select subscription
Select-AzSubscription -Subscription $subscriptionId 

#Get the VM
$vm = Get-AzVM -ResourceGroupName $resourceGroupName -Name $vmName

#Stop the VM
$vm | Stop-AzVM -force

# Get all disks in the resource group of the VM
$vmDisks = Get-AzDisk -ResourceGroupName $rgName 

# For disks that belong to the selected VM, convert to Selected Storage
foreach ($disk in $vmDisks)
{
	if ($disk.ManagedBy -eq $vm.Id)
	{
		$disk.Sku = [Microsoft.Azure.Management.Compute.Models.DiskSku]::new($storageType)
		$disk | Update-AzDisk
	}
}

$vm | Start-AzVM
