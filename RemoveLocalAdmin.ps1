$title = "Remove user from Administrators or Remote Desktop Group"
$message = "Please select the group that you would like to remove the user from"
$DomainUser = Read-Host -Prompt "Input the Username"
$Computer   = Read-Host -Prompt "Input the Computer Name"
$admingroup = "Administrators" #This will remove the user to the Administrators group which will allow admin access along with RDP access
$rdpgroup = "Remote Desktop" #This will remove the user to the RDP group but nnot grant them admin rights
$Domain     = "DOMAIN.LOCAL" 

$administrators = New-Object System.Management.Automation.Host.ChoiceDescription "&Administrators",
     "Removes the user from the administrators group on the specified machine"

$remotedesktop = New-Object System.Management.Automation.Host.ChoiceDescription "&RemoteDesktop",
     "Removes user from the RDP group on the specified machine"

$options = [System.Management.Automation.Host.ChoiceDescription[]] ($Administrators, $RDP)

$result = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($result)
    {
        0 {
            ([ADSI]"WinNT://$Computer/$admingroup,group").psbase.Invoke("Remove",([ADSI]"WinNT://$Domain/$DomainUser").path)
            Write-Host "$DomainUser has been removed from the $admingroup on $Computer"
          }
        1 {
            ([ADSI]"WinNT://$Computer/$rdpgroup,group").psbase.Invoke("Remove",([ADSI]"WinNT://$Domain/$DomainUser").path)
            Write-Host "$DomainUser has been removed from the $rdpgroup on $Computer"
          }
    }