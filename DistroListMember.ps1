$DistroList = Read-Host -Prompt "Input the Distribution List Name:" #Must be the full CN exactly as displayed in AD

#Gets the members of specified distribution group and sorts them alphabetically and copies them to your clipboard
Get-ADGroupMember -Identity $DistroList | % { (Get-ADUser $_ -Properties EmailAddress).EmailAddress } | sort | clip