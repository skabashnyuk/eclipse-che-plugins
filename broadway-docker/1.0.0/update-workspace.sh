#! /bin/bash
set -e
set -u

CHE_HOST=$(oc get -o json  routes/che -o=go-template='{{ .spec.host }}')
curl -X POST --data-binary @.devfile -H "Content-type: text/x-yaml" http://$CHE_HOST/api/devfile
