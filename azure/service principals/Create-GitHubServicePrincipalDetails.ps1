<#
.SYNOPSIS
    Create Service Principal and output to save as git secret

.DESCRIPTION
    Creates app registration wth permission to the relevant scope

.PARAMETER servicePrincipalName
    The name of the service principal to create

.PARAMETER scope
    Scope in which to grant permissions


.NOTES
	Version      : 2.0.0.0
	Last Updated : 2021-05-11
	Author       : Will Jones
	Keywords     : Azure AD, Service Principals
	Open Issues  :

#>

Param(
    [Parameter(Mandatory = $true)]
    [string]
    $servicePrincipalName,

    [Parameter(Mandatory = $true)]
    [string]
    $scope


)

az ad sp create-for-rbac --name $servicePrincipalName --role contributor --scopes $scope --sdk-auth






