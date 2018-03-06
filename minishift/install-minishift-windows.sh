#!/usr/bin/env bash

set -e

minishiftUrl=$(curl -s https://api.github.com/repos/minishift/minishift/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep windows | grep -v sha)
echo "will download $minishiftUrl"
curl $minishiftUrl -o minishift.zip -L
unzip -j -o minishift.zip '*/minishift.exe'
