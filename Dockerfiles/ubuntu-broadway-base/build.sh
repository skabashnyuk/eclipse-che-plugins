#! /bin/bash
set -e
set -u


dockerImageName=ksmster/ubuntu-broadway-base
echo "Building docker image $dockerImageName"
docker build . -t ${dockerImageName}
docker push ${dockerImageName}

