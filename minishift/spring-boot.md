# deploy spring boot

## install openjdk18-web-basic-s2i template
[blog post](https://medium.com/@pablo127/deploy-spring-boot-application-to-openshift-3-next-gen-2b311f55f0c5)
```bash
./import-java8-template.sh
```

## deploy playground-api
```bash
oc new-app openshift/openjdk18-web-basic-s2i~https://github.com/lukaszjdrzewiecki/playground-api.git
oc expose svc/playground-api

curl -v -L $(oc get route/playground-api --no-headers -o jsonpath='{.status.ingress[*].host}')/playground-api
```

## deploy playground-frontend
```bash
oc new-app openshift/nodejs:6~https://github.com/kamkie/SimpleSchoolApp.git  -e DOCKER_BACKEND_API=http://$(oc get route/playground-api --no-headers -o jsonpath='{.status.ingress[*].host}')/playground-api

$(oc get route/playground-api --no-headers -o jsonpath='{.status.ingress[*].host}')/playground-api
oc expose svc/simpleschoolapp

curl -v -L $(oc get route/simpleschoolapp --no-headers -o jsonpath='{.status.ingress[*].host}')/api
```

## check version
```bash
curl -v -L $(oc get route/simpleschoolapp --no-headers -o jsonpath='{.status.ingress[*].host}')/api/info
```
