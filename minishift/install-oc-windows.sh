#!/usr/bin/env bash

set -e

ocUrl=$(curl -s https://api.github.com/repos/openshift/origin/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep windows)
echo "will download $ocUrl"
curl $ocUrl -o oc.zip -L
unzip -j -o oc.zip 'oc.exe'
