Import-module .\common\Write-HostColored.ps1 -Force

Start-Transcript -path init-windows.log -append

echo 'checking prerequisites on windows'

$isUserHypervAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole('S-1-5-32-578')

Write-HostColored "check if user is in hyper-v admin group: #green#$isUserHypervAdmin#"

Stop-Transcript
