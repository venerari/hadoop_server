#$sp = $args[0]
#$passWord = $args[1]

## THIS IS NOW MANUAL FOR NOW ################################################################

#az login --service-principal --username 08009a36-bf30-4f05-9399-be3db446dc6a --password $sp --tenant 78448480-3203-4553-bdb0-bf1dad1a07cd

# when using ur powershell, go to the hadoop_server/powershell

az login --service-principal --username 08009a36-bf30-4f05-9399-be3db446dc6a --password k5zD8jK8rRpqTvPPsw0_98vs-OvzNz~i1E --tenant 78448480-3203-4553-bdb0-bf1dad1a07cd --verbose

$resourceGroup = "hadoopcluster"
$dcLocation = "canadacentral"
$vmName = "dcsit"

az vm run-command invoke -g $resourceGroup -n $vmName --command-id RunPowerShellScript --scripts '@create_dcsit1.ps1' --parameters 'arg1=Clark@12345!' --verbose

# dc1 reboot will happen in 6-10 min 
 
az vm run-command invoke -g $resourceGroup -n $vmName --command-id RunPowerShellScript --scripts '@create_dcsit2.ps1' --verbose
