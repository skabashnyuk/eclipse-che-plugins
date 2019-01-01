#!/bin/bash
set -e

nohup /usr/bin/broadwayd :5 &> /var/log/broadway.log &

GDK_BACKEND=broadway BROADWAY_DISPLAY=:5 java -jar /root/eclipse/plugins/org.eclipse.equinox.launcher_1.5.100.v20180827-1352.jar -data /projects
