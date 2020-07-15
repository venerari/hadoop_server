$passWord = 'Clark@12345!'
#$args[1]
$userName = 'azure'
$pwdSecureString = ConvertTo-SecureString -Force -AsPlainText $passWord
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $userName, $pwdSecureString

# add domain services 
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Verbose

Import-Module ADDSDeployment

Install-ADDSForest -SkipPreChecks -DomainName "test015.org" -InstallDns -SafeModeAdministratorPassword $pwdSecureString -Confirm -Force -Verbose
#-NoRebootOnCompletion
