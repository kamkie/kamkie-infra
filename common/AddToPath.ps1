Import-module .\common\Write-HostColored.ps1 -Force

function AddToPath([string]$pathToAdd)
{
    if (![string]::IsNullOrEmpty($pathToAdd))
    {
        if (!($env:Path.Split(';')).contains($pathToAdd))
        {
            Write-HostColored "will add directory #green#$pathToAdd# to path"
            $newPath = $env:Path + ";$pathToAdd"
            Write-HostColored "new path will be #yellow#$newPath#"
            [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::User)
            [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Process)
        }
        else
        {
            Write-HostColored "directory #green#$pathToAdd# is already in path: #yellow#$([Environment]::GetEnvironmentVariable("Path") )#"
        }
    }
    else
    {
        Write-HostColored "#red#can't add empty string to path"
    }
}

