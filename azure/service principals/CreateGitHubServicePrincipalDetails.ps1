write-host "Service Principal Creation"
$servicePrincipalName = $args[0]
$scope = $args[1]


az ad sp create-for-rbac --name $servicePrincipalName --role contributor --scope $scope --sdk-auth

