#!/usr/bin/env bash

set -e

./install-oc-windows.sh
./install-minishift-windows.sh
powershell -F add-to-path-windows.ps1
powershell -F sudo.ps1 powershell -C '([adsi]”WinNT://./Hyper-V Administrators,group”).Add(“WinNT://$env:UserDomain/$env:Username,user”)'
