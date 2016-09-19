$username = Read-Host -Prompt "Input Username to unlock here:"
Unlock-ADAccount -Identity $username 
Write-Host "The account $username has been unlocked."