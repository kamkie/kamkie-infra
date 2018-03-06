if (!($env:Path).contains($((pwd).Path))) {
    echo 'will add current directory to path'
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$((pwd).Path)", [EnvironmentVariableTarget]::User)
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$((pwd).Path)", [EnvironmentVariableTarget]::Process)
}
[Environment]::GetEnvironmentVariable("Path")

