$sp = "k5zD8jK8rRpqTvPPsw0_98vs-OvzNz~i1E" 
$passWord = "Clark@12345!"
$resourceGroup = "hadoopcluster"
$dcLocation = "canadacentral"
$vmName = "dcdev"
$vnet = "hadoop-network"
$nsg1 = "dcdevnsg1"
$dcdevrule1 = "dcdevrdp1"
$dcdevNic = "dcdevnic1"
$dcdevIPConfig1 = "dcdevipconfig1"
$hdpsubnetdev = "subnetdev"
$dcdevPublicIP1 = "dcdevpublicip1"
$dcdevNic1 = "dcdevnic1"
$userName = "azure"
$avSet1 = "avsetdev"

az login --service-principal --username 08009a36-bf30-4f05-9399-be3db446dc6a --password $sp --tenant 78448480-3203-4553-bdb0-bf1dad1a07cd 

az group create --name $resourceGroup --location $dcLocation 

az network vnet create --name $vnet --resource-group $resourceGroup --location $dcLocation --address-prefix 10.0.0.0/16 
az network vnet subnet create -g $resourceGroup --vnet-name $vnet -n $hdpsubnetdev --address-prefixes 10.0.0.0/24 

az network public-ip create --name $dcdevPublicIP1 --resource-group $resourceGroup  

az network nsg create -g $resourceGroup -n $nsg1 

az network nsg rule create -g $resourceGroup --nsg-name $nsg1 -n dcdevrule1 --priority 900 --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges 3389 --access Allow --protocol Tcp  

az network nic create --resource-group $resourceGroup --name $dcdevNic1 --vnet-name $vnet --subnet $hdpsubnetdev --network-security-group $nsg1 --public-ip-address $dcdevPublicIP1 

az vm availability-set create -n $avSet1 -g $resourceGroup --platform-fault-domain-count 3 --platform-update-domain-count 10 

az vm create --resource-group $resourceGroup --name $vmName --location $dcLocation --nic $dcdevNic1 --image win2016datacenter --admin-username $userName --admin-password $passWord --size Standard_B4ms --availability-set $avSet1 --private-ip-address 10.0.0.4 --storage-sku Premium_LRS 
