#!/bin/bash
set -e

export USER_ID=$(id -u)
export GROUP_ID=$(id -g)

if ! grep -Fq "${USER_ID}" /etc/passwd; then
    # current user is an arbitrary 
    # user (its uid is not in the 
    # container /etc/passwd). Let's fix that    
    cat ${HOME}/passwd.template | \
    sed "s/\${USER_ID}/${USER_ID}/g" | \
    sed "s/\${GROUP_ID}/${GROUP_ID}/g" | \
    sed "s/\${HOME}/\/home\/user/g" > /etc/passwd
    
    cat ${HOME}/group.template | \
    sed "s/\${USER_ID}/${USER_ID}/g" | \
    sed "s/\${GROUP_ID}/${GROUP_ID}/g" | \
    sed "s/\${HOME}/\/home\/user/g" > /etc/group
fi

export LANG="en_US.UTF-8"
export LC_MEASUREMENT="en_US.utf8"
export LC_MONETARY="en_US.utf8"
export LC_NUMERIC="en_US.utf8"
export LC_PAPER="en_US.utf8"
export LC_TIME="en_US.utf8"
export XDG_CURRENT_DESKTOP=GNOME
export XDG_MENU_PREFIX="gnome-"
export HOME="/home/user"
export SHELL="/bin/bash"
export PATH="/opt/gimp/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
export XDG_CONFIG_DIRS="/opt/gimp/etc/xdg:/etc"
export XDG_DATA_DIRS="/opt/gimp/share:/usr/share"

export DBUS_SESSION_BUS_ADDRESS=`dbus-daemon --session --print-address --fork`
broadwayd&
/panel.js&
exec simple_init