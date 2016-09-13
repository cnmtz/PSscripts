$DomainUser = Read-Host -Prompt "Input the Username"
$LocalGroup = "Administrators"
$Computer   = Read-Host -Prompt "Input the Computer Name"
$Domain     = "na.drillinginfo.com"


#Adds the specified username to the "Administrators" group on the local machine
([ADSI]"WinNT://$Computer/$LocalGroup,group").psbase.Invoke("Add",([ADSI]"WinNT://$Domain/$DomainUser").path)