$sp = "k5zD8jK8rRpqTvPPsw0_98vs-OvzNz~i1E" 
$resourceGroup = "hadoopcluster"
$dcLocation = "canadacentral"

az login --service-principal --username 08009a36-bf30-4f05-9399-be3db446dc6a --password $sp --tenant 78448480-3203-4553-bdb0-bf1dad1a07cd --verbose

$vmName = "agent1"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "agent2"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "dbdev"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "dbsit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose

$vmName = "hdmas1dev"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdkfk1dev"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdspk1dev"
az vm restart --resource-group $resourceGroup --name $vmName --verbose

$vmName = "hdmas1sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdmas2sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdkfk1sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdkfk2sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdkfk3sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdspk1sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdspk2sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
$vmName = "hdspk3sit"
az vm restart --resource-group $resourceGroup --name $vmName --verbose
