#!powershell

$title = "Restart IIS"
$message = "Do you want to restart IIS on the server?"
$remoteservername = Read-Host -Prompt "Please enter the name of the server to Reset IIS on"
$server = $remoteservername + "DOMAIN.LOCAL"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes",
     "Resets IIS on the server"

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No",
     "Exits and doesn't reset IIS"

$options = [System.Management.Automation.Host.ChoiceDescription[]] ($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($result)
    {
        0 {invoke-command -computername $remoteservername -scriptblock {iisreset}}
        1 {"You selected No. The server has remained untouched"}
    }