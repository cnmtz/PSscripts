#!powershell

import-module ActiveDirectory

$Firstname = Read-Host -Prompt "Input the user's First Name here"
$LastName = Read-Host -Prompt "Input the user's Last Name here"
$title = Read-Host -Prompt "Input the user's Title here"
$ipExtension = Read-Host -Prompt "Input the user's phone extension here"
$randomgen = -join ((65..90) + (97..122) | Get-Random -Count 12 | % {[char]$_})
$clonedusername = Read-Host -Prompt "Input the username to close group memberships from"
$username= $FirstName + "." + $LastName
$Fullname = $Firstname + "` " + $LastName
$samaccountname = $username.ToLower()
$email = $samaccountname + "@drillinginfo.com"
$password = $randomgen + "1!"
$upn = "$samaccountname@na.drillinginfo.com"  

#Create New Users' Account
New-ADUser -Name $Fullname -SamAccountName "$samaccountname" -GivenName "$FirstName" -Surname "$LastName" -AccountPassword (ConvertTo-SecureString -AsPlainText $password -Force) -DisplayName "$Fullname" -Path "OU=Users,OU=AUTOMATION,OU=-Austin,DC=na,DC=drillinginfo,DC=com" -UserPrincipalName "$upn" -Title "$title" -EmailAddress "$email" -Enabled $true -OtherAttributes @{ipPhone="$ipExtension"}

#Prints the password onscreen for immediate use if necessary to access the account
Write-Host $password

#Queries the memberof properties of the specified user to clone, Selects the memberof properties of the user to clone, Adds the newly created user to all of the same groups
Get-ADUser -Identity $clonedusername -Properties Memberof |
Select-Object -ExpandProperty memberof |
Add-ADGroupMember -Members $samaccountname

