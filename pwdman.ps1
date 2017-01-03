$title = "Force or Postpone password reset for entire OU"
$message = "Please select whether you'd like to Force or Postpone password resets"
$OU = Read-Host -Prompt "Please enter the full OU path (i.e. OU=testpwdman,OU=Users,OU=IT,OU=-Austin,DC=na,DC=drillinginfo,DC=com)"
$DC = Read-Host -Prompt "Please enter the domain controller"
$forcereset = New-Object System.Management.Automation.Host.ChoiceDescription "&ForceReset",
     "Forces all users in specified OU to reset their passwords"
$postponereset = New-Object System.Management.Automation.Host.ChoiceDescription "&PostponeReset",
     "Postpones password reset for all users in specified OU for 90 days."
$options = [System.Management.Automation.Host.ChoiceDescription[]] ($ForceReset, $PostponeReset)
$result = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($result)
    {
        0 {
            $list = Get-ADUser -searchbase "$OU" -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties “sAMAccountName”, “msDS-UserPasswordExpiryTimeComputed” | Select-Object  -Property “sAMAccountName”,@{Name=“ExpiryDate”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}} 
            foreach ($entry in $list) {
                $user = $entry.samaccountname 
                $todouser = Get-ADUser $user -Properties pwdLastSet -Server $DC
     
                $todouser.pwdLastSet = 0 
                Set-ADUser -Instance $todouser 
                Write-Host "Password reset has been forced for $user"
            }
          }
        1 {
            $list = Get-ADUser -searchbase "$OU" -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties “sAMAccountName”, “msDS-UserPasswordExpiryTimeComputed” | Select-Object  -Property “sAMAccountName”,@{Name=“ExpiryDate”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}}
            foreach ($entry in $list) {
                $user = $entry.samaccountname 
                $todouser = Get-ADUser $user -Properties pwdLastSet -Server $DC
                
                $todouser.pwdLastSet = 0 
                Set-ADUser -Instance $todouser

                $todouser.pwdLastSet = -1 
                Set-ADUser -Instance $todouser

                $newexpirydate = Get-ADUser -Identity $user –Properties “msDS-UserPasswordExpiryTimeComputed” | Select-Object -Property @{Name=“ExpiryDate”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}}

                Write-Host "Expiration postponed: $user ExpiryDate: $newexpirydate"
            }
          }
    }