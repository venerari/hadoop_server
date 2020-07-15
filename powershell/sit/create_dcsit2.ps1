Import-Module ActiveDirectory

#create subnet
New-ADReplicationSubnet -Name "10.0.10.0/24" -Site Default-First-Site-Name

# new user
New-ADUser -Name "admin" -GivenName "hdp" -Surname "admin" -SamAccountName "admin" -UserPrincipalName "admin@test015.org" -Path "CN=Users,DC=test015,DC=org" -AccountPassword (ConvertTo-SecureString "Clark@12345!" -AsPlainText -force) -Enabled $true

# new group
New-ADGroup -Name "admins" -SamAccountName admins -GroupCategory Security -GroupScope Global -DisplayName "Admins" -Path "CN=Users,DC=test015,DC=Org" -Description "Admins for linux sudoers"

# add admin to admins
Add-ADGroupMember -Identity "Domain Admins" -Members admin 
Add-ADGroupMember -Identity admins -Members admin

# need OU for hadoop (hpdadmin can create object)
New-ADOrganizationalUnit -Name "hadoopsit" -Path "DC=test015,DC=ORG" -ProtectedFromAccidentalDeletion $False

#create revese lookup dns
Add-DnsServerPrimaryZone -DynamicUpdate Secure -NetworkId '10.0.10.0/24' -ReplicationScope Domain

# add dns entry

Add-DnsServerResourceRecordA -Name "hdmas1sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.11" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdmas2sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.12" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdkfk1sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.13" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdkfk2sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.14" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdkfk3sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.15" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdspk1sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.16" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdspk2sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.17" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "hdspk3sit" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.18" -TimeToLive 01:00:00 -CreatePtr -Verbose
Add-DnsServerResourceRecordA -Name "dbdev" -ZoneName "test015.org" -AllowUpdateAny -IPv4Address "10.0.10.6" -TimeToLive 01:00:00 -CreatePtr -Verbose
