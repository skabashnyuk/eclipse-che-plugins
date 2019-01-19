#! /bin/bash
set -e
set -u


oc login -u developer -p developer >> /dev/null 
CHE_HOST=$(oc get -o json --namespace  eclipse-che  routes/che -o=go-template='{{ .spec.host }}')
echo "Using Che api server ${CHE_HOST}"
find . -name ".devfile" \
   -exec echo 'Creating workspace with devfile {}' \; \
   -exec curl --silent --output /dev/null -X POST --data-binary @{} -H "Content-type: text/x-yaml" http://$CHE_HOST/api/devfile \;
find . -name "fix.sh" \
   -exec echo 'Fixing issues {}' \; \
   -exec '{}'  \;

  
