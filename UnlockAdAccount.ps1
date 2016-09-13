$username = Read-Host -Prompt "Input Username to unlock here:"
Unlock-ADAccount -Identity $username 