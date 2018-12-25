#! /bin/bash
set -e
set -u


dockerImageName=ksmster/che-editor-$(yq r meta.yaml name)
echo "Building docker image $dockerImageName"
docker build . -t ${dockerImageName}
#docker push ${dockerImageName}

set +e
git diff -s --exit-code  che-plugin.yaml
CHE_PLUGIN_CHANGED=$?
set -e
if [[ $CHE_PLUGIN_CHANGED -eq 1 ]]; then
   echo "che-plugin.yaml  changed repackaging";
   if [ -f che-editor-plugin.tar.gz ]; then
    rm che-editor-plugin.tar.gz
   fi
   tar zcf che-editor-plugin.tar.gz che-plugin.yaml
   git add che-plugin.yaml
   git add che-editor-plugin.tar.gz
   git commit -m "Update changes in che-plugin.yaml"
   git push
fi

