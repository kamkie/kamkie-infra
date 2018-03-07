# deploy spring boot

## install openjdk18-web-basic-s2i template
[blog post](https://medium.com/@pablo127/deploy-spring-boot-application-to-openshift-3-next-gen-2b311f55f0c5)
```bash
./import-java8-template.sh
```

## deploy playground-api
1```bash
oc new-app openshift/openjdk18-web-basic-s2i~https://github.com/lukaszjdrzewiecki/playground-api.git
oc expose svc/playground-api

curl -v -L $(oc get route/playground-api --no-headers -o jsonpath='{.status.ingress[*].host}')/playground-api
```
