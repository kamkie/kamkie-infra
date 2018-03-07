#!/usr/bin/env bash

set -e

oc_project=$(oc project -q)
oc project openshift
oc apply -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/openjdk/openjdk18-web-basic-s2i.json
oc import-image my-redhat-openjdk-18/openjdk18-web-basic-s2i --from=registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift --confirm
oc project $oc_project
