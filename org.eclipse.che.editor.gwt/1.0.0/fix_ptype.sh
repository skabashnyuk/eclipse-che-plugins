#! /bin/bash
set -e
set -u
oc login -u developer -p developer
CHE_HOST=$(oc get -o json --namespace  eclipse-che  routes/che -o=go-template='{{ .spec.host }}')
WORKSPACE_NAME=$(yq r .devfile  name)
WS_ID=$(curl -s "http://$CHE_HOST/api/workspace/che/$WORKSPACE_NAME" | jq  -r  '.id')
echo "Fixing gwt-id at $CHE_HOST in workspace $WORKSPACE_NAME  $WS_ID"
curl -s "http://$CHE_HOST/api/workspace/che/$WORKSPACE_NAME"| jq '.config.projects[0].type = "blank"' | curl -s -X PUT  -d @- -H 'Content-Type: application/json;charset=UTF-8' "http://$CHE_HOST/api/workspace/$WS_ID"
curl -s  "http://$CHE_HOST/api/workspace/che/$WORKSPACE_NAME" | jq .