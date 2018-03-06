#!/usr/bin/env bash

set -e

./install-oc-windows.sh
./install-minishift-windows.sh
powershell -F add-to-path-windows.ps1
