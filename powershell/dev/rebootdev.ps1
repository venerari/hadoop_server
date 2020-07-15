$sp = $args[0]
$resourceGroup = "hadoopcluster"
$dcLocation = "canadacentral"

az login --service-principal --username 08009a36-bf30-4f05-9399-be3db446dc6a --password $sp --tenant 78448480-3203-4553-bdb0-bf1dad1a07cd --verbose

$vmName = "hdmas1dev"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdkfk1dev"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdspk1dev"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
