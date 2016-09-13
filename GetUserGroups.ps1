do 
    {
        $a = Read-Host "Please enter the user's name"
        if ($a -ne "")
        {$a + "`n" + "=========================="; Get-ADPrincipalGroupMembership $a | select name | clip }
    } 
while ($a -ne "")