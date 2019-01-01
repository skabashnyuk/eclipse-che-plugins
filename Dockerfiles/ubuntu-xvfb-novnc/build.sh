#! /bin/bash
set -e
set -u


dockerImageName=ksmster/ubuntu-xvfb-novnc
echo "Building docker image $dockerImageName"
docker build . -t ${dockerImageName}
docker push ${dockerImageName}

