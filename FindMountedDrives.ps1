$file = "C:\Users\ian.martinez\Desktop\comp.txt"
$comp = Get-Content -Path $file
$comp | ForEach-Object -Process {Invoke-Command -ComputerName "$_" {Get-WmiObject Win32_MappedLogicalDisk  | select name, providername}}