##Requires -RunAsAdministrator

Import-module .\common\Write-HostColored.ps1 -Force
Import-module .\common\IsAdmin.ps1 -Force
Import-module .\common\AddToPath.ps1 -Force
Import-module .\common\IIF.ps1 -Force

Start-Transcript -path logs\init-windows.log -append

Write-Output 'checking prerequisites on windows'

$userName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$isElevated = IsAdmin
$colorForIsElevated = IIF $isElevated "green" "red"
Write-HostColored "user name: #yellow#$userName# is elevated: #$colorForIsElevated#$isElevated#"

$user = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
$isUserHypervAdmin = $user.IsInRole('S-1-5-32-578')

Write-HostColored "check if user is in hyper-v admin group: #green#$isUserHypervAdmin#"

AddToPath $pwd

Stop-Transcript
