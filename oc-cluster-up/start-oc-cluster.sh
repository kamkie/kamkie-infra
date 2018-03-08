#!/usr/bin/env bash

set -e

oc version || true
oc cluster down || true
oc cluster up \
  --metrics=true \
  --logging=true \
  --version=v3.7 \
  --use-existing-config=true \
  --service-catalog=true \
  --host-data-dir=//var/lib/origin/openshift.local.data \
  --host-config-dir=//var/lib/origin/openshift.local.config \
  --host-pv-dir=//var/lib/origin/openshift.local.pv \
  --host-volumes-dir=//var/lib/origin/openshift.local.volumes

oc login -u system:admin

oc create user admin --full-name=admin || true
oc adm policy add-cluster-role-to-user cluster-admin admin
