$DomainUser = Read-Host -Prompt "Input the Username"
$LocalGroup = "Administrators"
$Computer   = Read-Host -Prompt "Input the Computer Name"
$Domain     = "na.drillinginfo.com"

([ADSI]"WinNT://$Computer/$LocalGroup,group").psbase.Invoke("Remove",([ADSI]"WinNT://$Domain/$DomainUser").path)