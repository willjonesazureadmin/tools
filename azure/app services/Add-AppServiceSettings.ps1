$webapp=Get-AzWebApp -ResourceGroupName $resourceGroupName  -Name $appName
 
$appSettings=$webapp.SiteConfig.AppSettings
$newAppSettings = @{}
ForEach ($item in $appSettings) {
$newAppSettings[$item.Name] = $item.Value
}

$newAppSettings['WEBSITE_RUN_FROM_PACKAGE'] = $urlToAppbinary

Set-AzWebApp -ResourceGroupName $resourceGroupName -Name $appName  -AppSettings $newAppSettings