#! /bin/bash
set -e
set -u

eval $(minishift docker-env)
declare -a IMAGES=("eclipse/ubuntu_jdk8" \
    "openjdk:8u181-jdk-alpine" \
    "ksmster/che-editor-filebrowser" \
    "ksmster/che-editor-gedit-sample" \
    "ksmster/che-editor-intellij-sample" \
    "ksmster/che-editor-jupyter-notebook"  \
    "dirigiblelabs/dirigible-openshift"  \
    "wsskeleton/eclipse-broadway" \
    "wsskeleton/che-machine-exec" \
    "eclipse/che-theia:0.3.18-nightly" \
    "eclipse/che-editor-gwt-ide:nightly" \
    "eclipse/che-server:nightly"
    )

## now loop through the above array
for i in "${IMAGES[@]}"
do
   echo "$i"
   docker pull $i
done

# You can access them using echo "${arr[0]}", "${arr[1]}" also