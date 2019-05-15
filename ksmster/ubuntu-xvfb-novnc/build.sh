#! /bin/bash
set -e
set -u


dockerImageName=ksmster/ubuntu-xvfb-novnc
echo "Building docker image $dockerImageName"
docker build --no-cache . -t ${dockerImageName}
docker push ${dockerImageName}

