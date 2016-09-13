$DistroList = Read-Host -Prompt "Input the Distribution List Name:"


Get-ADGroupMember -Identity $DistroList | % { (Get-ADUser $_ -Properties EmailAddress).EmailAddress } | sort | clip