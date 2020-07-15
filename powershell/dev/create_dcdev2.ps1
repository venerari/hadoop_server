Import-Module ActiveDirectory

#create subnet
New-ADReplicationSubnet -Name "10.0.0.0/24" -Site Default-First-Site-Name

# new user
New-ADUser -Name "admin" -GivenName "hdp" -Surname "admin" -SamAccountName "admin" -UserPrincipalName "admin@test014.org" -Path "CN=Users,DC=test014,DC=org" -AccountPassword (ConvertTo-SecureString "Clark@12345!" -AsPlainText -force) -Enabled $true

# new group
New-ADGroup -Name "admins" -SamAccountName admins -GroupCategory Security -GroupScope Global -DisplayName "Admins" -Path "CN=Users,DC=test014,DC=Org" -Description "Admins for linux sudoers"

# add admin to admins
Add-ADGroupMember -Identity "Domain Admins" -Members admin 
Add-ADGroupMember -Identity admins -Members admin

# need OU for hadoop (hpdadmin can create object)
New-ADOrganizationalUnit -Name "hadoopdev" -Path "DC=TEST014,DC=ORG" -ProtectedFromAccidentalDeletion $False

#create revese lookup dns
Add-DnsServerPrimaryZone -DynamicUpdate Secure -NetworkId '10.0.0.0/24' -ReplicationScope Domain

# add dns entry

Add-DnsServerResourceRecordA -Name "hdmas1dev" -ZoneName "test014.org" -AllowUpdateAny -IPv4Address "10.0.0.11" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdkfk1dev" -ZoneName "test014.org" -AllowUpdateAny -IPv4Address "10.0.0.12" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdspk1dev" -ZoneName "test014.org" -AllowUpdateAny -IPv4Address "10.0.0.13" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "dbdev" -ZoneName "test014.org" -AllowUpdateAny -IPv4Address "10.0.0.6" -TimeToLive 01:00:00 -CreatePtr -Verbose
