Param(     
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]
    $RecoveryVaultName,       
    [Parameter(Mandatory = $true)]
    [string]
    $VMResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]
    $vmname,
    [Parameter(Mandatory = $true)]
    [string]
    $BackupPolicyName
)
$ErrorActionPreference = "Stop"

    Write-Output "[INFO] RecoveryVaultName = $RecoveryVaultName"
    Write-Output "[INFO] RecoveryVaultName = $BackupPolicyName"

    $Vault = Get-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $RecoveryVaultName
    Set-AzRecoveryServicesVaultContext -Vault $Vault

    $policy = Get-AzRecoveryServicesBackupProtectionPolicy  -Name "$BackupPolicyName" -Vault $Vault.ID

    Enable-AzRecoveryServicesBackupProtection `
        -ResourceGroupName $VMResourceGroupName -Name $vmname -Policy $policy
    Write-Output "[INFO] VMBackup with Policy $BackupPolicyName has been configured "
