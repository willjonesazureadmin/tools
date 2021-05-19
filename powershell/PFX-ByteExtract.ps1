<#
.SYNOPSIS
    Extract a password protect PFX to byte stream to allow import into Azure keyvault or othertools
    
.PARAMETER CertPath
    File path to cert to extract

.EXAMPLE
    .\PFT-ByteExtract.ps1 -certPath  awa-weu-pmp-be-001 
.NOTES
	Version      : 0.0.0.1
	Last Updated : 2021-05-19
	Author       : Will Jones
	Keywords     : Certificates
	Open Issues  :
#>

Param(
    [Parameter(Mandatory = $true)]
    [string]
    $certPath

)

$cert = Get-Content -AsByteStream -Path $certPath
[System.Convert]::ToBase64String($cert) | Out-File 'pfx-bytes.txt'
