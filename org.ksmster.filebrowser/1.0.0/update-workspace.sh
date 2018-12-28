#! /bin/bash
set -e
set -u
oc login -u developer -p developer
CHE_HOST=$(oc get -o json --namespace  eclipse-che  routes/che -o=go-template='{{ .spec.host }}')
echo "Creaing workspace in $CHE_HOST"
curl -X POST --data-binary @.devfile -H "Content-type: text/x-yaml" http://$CHE_HOST/api/devfile
