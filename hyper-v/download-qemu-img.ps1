$qemuPackage = 'qemu-img-win-x64-2_3_0.zip'
$qemuImgUrl = "https://cloudbase.it/downloads/$qemuPackage"
$packageFile = "$PSScriptRoot\$qemuPackage"

if (!(Test-Path $packageFile -PathType Leaf))
{
    Invoke-WebRequest -Uri $qemuImgUrl -OutFile $packageFile
}
else
{
    echo "qemu-img already exists"
}

if (!(Test-Path "$PSScriptRoot\qemu-img\qemu-img.exe" -PathType Leaf))
{
    Expand-Archive $packageFile -DestinationPath "$PSScriptRoot\qemu-img\"
}
