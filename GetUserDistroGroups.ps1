do 
    {
        $a = Read-Host "Please enter the user's name"
        if ($a -ne "")
        {$a + "`n" + "=========================="; Get-ADPrincipalGroupMembership $a | Where-Object {$_.GroupCategory -eq "Distribution"} | select name | sort | clip }
    } 
while ($a -ne "")