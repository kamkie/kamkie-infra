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
