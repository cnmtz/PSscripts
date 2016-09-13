$DomainUser = Read-Host -Prompt "Input the Username"
$LocalGroup = "Administrators"
$Computer   = Read-Host -Prompt "Input the Computer Name"
$Domain     = "na.drillinginfo.com"

([ADSI]"WinNT://$Computer/$LocalGroup,group").psbase.Invoke("Add",([ADSI]"WinNT://$Domain/$DomainUser").path)