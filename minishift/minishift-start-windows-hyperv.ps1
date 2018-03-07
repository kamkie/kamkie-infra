
#$SwitchName=(Get-VMNetworkAdapter -ALL | Where {$_.Status -Eq "Ok"} | Where {$_.SwitchName -NotLike "*nat*" }).SwitchName
#[Environment]::SetEnvironmentVariable("HYPERV_VIRTUAL_SWITCH", $SwitchName, [EnvironmentVariableTarget]::User)
#[Environment]::SetEnvironmentVariable("HYPERV_VIRTUAL_SWITCH", $SwitchName, [EnvironmentVariableTarget]::Process)

New-NetNat -Name SharedNAT -InternalIPInterfaceAddressPrefix 10.0.75.1/24
$env:MINISHIFT_ENABLE_EXPERIMENTAL="y"
$env:HYPERV_VIRTUAL_SWITCH="DockerNAT"

minishift delete -f
cd c:\
minishift start   --metrics   --logging   --logtostderr  --cpus 4   --memory 6GB   --disk-size 30GB   --vm-driver hyperv

minishift addons enable admin-user
minishift addons apply admin-user
minishift addons enable registry-route
minishift addons apply registry-route
oc login -u system:admin

minishift console
