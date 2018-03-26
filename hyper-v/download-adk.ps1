#Requires -RunAsAdministrator

Import-module .\common\Write-HostColored.ps1 -Force

$adkUrl = "https://go.microsoft.com/fwlink/p/?linkid=859206"
$packageFile = "$PSScriptRoot\adksetup.exe"

if (!(Test-Path $packageFile -PathType Leaf))
{
    Invoke-WebRequest -Uri $adkUrl -OutFile $packageFile
}
else
{
    echo "adk installer already exists"
}

$instalerDir = 'c:\tools\ADKoffline'
if (!(Test-Path $instalerDir))
{
    echo "downloading adk offline installer"
    &$packageFile /quiet /layout $instalerDir
}

while ((Get-Process -Name 'adksetup' -ErrorAction SilentlyContinue).count -gt 0)
{
    echo 'adksetup is running'
    Start-Sleep -s 5
}

&"$instalerDir\Installers\Windows Deployment Tools-x86_en-us.msi" /quiet

Write-HostColored "path to oscdimg: #green#C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe#"
