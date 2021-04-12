write-host "Secret manager script"
$projectPath = read-host "Enter a project path or leave blank for current path"
if($projectPath -eq "") { $projectPath = ".\"}

dotnet user-secrets init -p $projectPath
write-host "The following secrets have been found"
dotnet user-secrets list -p $projectPath

$secretKeyName = "."
while($secretKeyName.ToLower() -ne "q")
{
    write-host "Enter new secret or type Q to quit"
    $secretKeyName = read-host "Secret key name"
    if($secretKeyName.ToLower() -eq "q") { Break }
    $secretKeyValue = read-host "Secret key value"
    cls
    dotnet user-secrets set $secretKeyName $secretKeyValue  -p $projectPath
}
