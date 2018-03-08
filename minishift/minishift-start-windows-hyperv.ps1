
##$SwitchName=(Get-VMNetworkAdapter -ALL | Where {$_.Status -Eq "Ok"} | Where {$_.SwitchName -NotLike "*nat*" }).SwitchName

#$SwitchName='SwitchName'
#if (!(Get-VMNetworkAdapter -ALL | Where {$_.SwitchName -Eq $SwitchName })) {
#    New-VMSwitch -SwitchName $SwitchName -SwitchType Internal
#    New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceAlias "vEthernet ($SwitchName)" -AddressFamily IPv4
#    New-NetNat -Name $SwitchName -InternalIPInterfaceAddressPrefix 192.168.0.0/24
#    Get-NetIPAddress | Where {$_.InterfaceAlias -Eq 'vEthernet ($SwitchName)'}
#}

#[Environment]::SetEnvironmentVariable("HYPERV_VIRTUAL_SWITCH", $SwitchName, [EnvironmentVariableTarget]::User)
#[Environment]::SetEnvironmentVariable("HYPERV_VIRTUAL_SWITCH", $SwitchName, [EnvironmentVariableTarget]::Process)

$SwitchName='DockerNAT'
#New-NetNat -Name SharedNAT -InternalIPInterfaceAddressPrefix 10.0.75.1/24
$env:HYPERV_VIRTUAL_SWITCH=$SwitchName
echo HYPERV_VIRTUAL_SWITCH=$SwitchName
$env:MINISHIFT_ENABLE_EXPERIMENTAL="y"

minishift delete -f
cd c:\
minishift start `
  --metrics `
  --logging `
  --logtostderr `
  --cpus 4   --memory 6GB   --disk-size 30GB `
  --vm-driver hyperv

#  --network-ipaddress 10.0.75.124 `
#  --network-gateway 10.0.75.1 `
#  --network-nameserver 8.8.8.8

minishift addons enable admin-user
minishift addons apply admin-user
minishift addons enable registry-route
minishift addons apply registry-route
oc login -u system:admin

minishift console
