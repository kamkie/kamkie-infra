#!/usr/bin/env bash

set -e

export HYPERV_VIRTUAL_SWITCH="Default Switch"
minishift delete -f || true
cd /c
minishift start \
  --metrics \
  --logging \
  --logtostderr \
  --cpus 4 \
  --memory 6GB \
  --disk-size 30GB \
  --vm-driver hyperv

minishift addons enable admin-user
minishift addons apply admin-user
minishift addons enable registry-route
minishift addons apply registry-route
oc login -u system:admin

minishift console
