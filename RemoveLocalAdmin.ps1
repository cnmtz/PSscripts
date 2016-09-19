$title = "Remove user to Administrators or Remote Desktop Group"
$message = "Please select the group that you would like to Remove the user to"
$DomainUser = Read-Host -Prompt "Input the Username"
$Computer   = Read-Host -Prompt "Input the Computer Name"
$admingroup = "Administrators" #This will Remove the user to the Administrators group which will allow admin access along with RDP access
$rdpgroup = "Remote Desktop Users" #This will Remove the user to the RDP group but nnot grant them admin rights
$Domain     = "DOMAIN.LOCAL" 
$administrators = New-Object System.Management.Automation.Host.ChoiceDescription "&Administrators",
     "Removes the user to the administrators group on the specified machine"
$remotedesktop = New-Object System.Management.Automation.Host.ChoiceDescription "&RemoteDesktop",
     "Removes user to the RDP group on the specified machine"
$options = [System.Management.Automation.Host.ChoiceDescription[]] ($Administrators, $RemoteDesktop)
$result = $host.ui.PromptForChoice($title, $message, $options, 0)
switch ($result)
    {
        0 {
            ([ADSI]"WinNT://$Computer/$admingroup,group").psbase.Invoke("Remove",([ADSI]"WinNT://$Domain/$DomainUser").path)
            Write-Host "The Domain user $DomainUser has been Removed to the $admingroup on $Computer"
          }
        1 {
            ([ADSI]"WinNT://$Computer/$rdpgroup,group").psbase.Invoke("Remove",([ADSI]"WinNT://$Domain/$DomainUser").path)
            Write-Host "The domain user $DomainUser has been Removed to the $rdpgroup on $Computer"
          }
    }