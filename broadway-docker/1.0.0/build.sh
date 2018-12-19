#! /bin/bash
set -e
set -u


dockerImageName=ksmster/che-editor-$(yq r meta.yaml name)
docker build . -t ${dockerImageName}
sdocker push ${dockerImageName}
if [ -f che-editor-plugin.tar.gz ]; then
    rm che-editor-plugin.tar.gz
fi

tar zcf che-editor-plugin.tar.gz che-plugin.yaml