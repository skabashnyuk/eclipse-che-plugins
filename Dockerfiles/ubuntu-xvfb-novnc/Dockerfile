FROM ubuntu:18.04

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:6901/?password=vncpassword
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901
EXPOSE $VNC_PORT $NO_VNC_PORT

ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    

### Install some common tools
RUN echo "Install some common tools for further installation" \
    && apt-get update  \
    && apt-get install -y mc vim wget net-tools locales bzip2 \
        python-numpy #used for websockify/novnc \
    && apt-get clean -y
    
RUN echo "generate locales for en_US.UTF-8" && locale-gen en_US.UTF-8    
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

### Install custom fonts
RUN echo "Installing ttf-wqy-zenhei" \
    && apt-get install -y ttf-wqy-zenhei


# Install Xvfb
RUN apt-get update \
    && apt-get install -y xvfb x11vnc xterm \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*


# Add VNC startup script
COPY start-vnc-session.sh /usr/bin/
RUN chmod +x /usr/bin/start-vnc-session.sh

# This is a bit of a hack. At the moment we have no means of starting background
# tasks from a Dockerfile. This workaround checks, on each bashrc eval, if the X
# server is running on screen 0, and if not starts Xvfb, x11vnc and novnc.
RUN echo "[ ! -e /tmp/.X0-lock ] && (/usr/bin/start-vnc-session.sh 0 &> /tmp/display-0.log)" >> ~/.bashrc
RUN echo "export DISPLAY=:0" >> ~/.bashrc


### Envrionment config
ENV HOME=/home/user \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1920x1080 \
    NO_VNC_HOME=/home/user/novnc

WORKDIR $HOME

RUN useradd -u 1000 -G users,sudo,root -d /home/user --shell /bin/bash -m user  \
    && usermod -p "*" user  \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    # Create /projects for Che
    && mkdir /projects \
    && touch /var/log/supervisord.log \
    && cat /etc/passwd | sed s#root:x.*#root:x:\${USER_ID}:\${GROUP_ID}::\${HOME}:/bin/bash#g > ${HOME}/passwd.template \
    && cat /etc/group | sed s#root:x:0:#root:x:0:0,\${USER_ID}:#g > ${HOME}/group.template \
    # Cleanup tmp folder
    && rm -rf /tmp/* \
    # Change permissions to allow editing of files for openshift user
     && for f in "${HOME}" "/etc/passwd" "/etc/group" "/var/log/" "/projects"; do\
               chgrp -R 0 ${f} && \
               chmod -R g+rwX ${f}; \
           done ;

### Install noVNC - HTML5 based VNC viewer
RUN echo "Install noVNC - HTML5 based VNC viewer" \
    && mkdir -p $NO_VNC_HOME/utils/websockify \
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
     # use older version of websockify to prevent hanging connections on offline containers, see https://github.com/ConSol/docker-headless-vnc-container/issues/50
    && wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
    && chmod +x -v $NO_VNC_HOME/utils/*.sh
    ## create index.html to forward automatically to `vnc_lite.html`


