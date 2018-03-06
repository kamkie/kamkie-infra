#!/usr/bin/env bash

wget https://github.com/openshift/origin/releases/download/v3.7.1/openshift-origin-server-v3.7.1-ab0f056-linux-64bit.tar.gz
tar xvf openshift-origin-server-v3.7.1-ab0f056-linux-64bit.tar.gz
sudo mv oc /usr/bin
