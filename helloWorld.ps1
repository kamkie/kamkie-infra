Import-module .\common\Write-HostColored.ps1 -Force

Write-Output 'hello word'

Write-HostColored "pwd: #yellow#$pwd#"
Write-HostColored "path: #yellow#$env:Path#"
