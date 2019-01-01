FROM ubuntu:18.04

EXPOSE 6080

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8


RUN  apt-get update && apt-get -y install \
	mc \
	xvfb \
	x11vnc \
	supervisor \
	fluxbox \
	net-tools \
	wget \
	gedit

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

#=======
# noVNC
#=======
#RUN  wget -nv -O noVNC.zip "https://github.com/novnc/noVNC/archive/v1.0.0.zip" \
# && unzip -x noVNC.zip \
# && rm noVNC.zip  \
# && mv noVNC-1.0.0 /opt/noVNC \
# && wget -nv -O websockify.zip "https://github.com/novnc/websockify/archive/v0.8.0.zip" \
# && unzip -x websockify.zip \
# && mv websockify-0.8.0 /opt/noVNC/utils/websockify \
# && rm websockify.zip \
# && ln /opt/noVNC/vnc.html /opt/noVNC/index.html


RUN  mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/novnc/noVNC/tarball/master" |  tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/novnc/websockify/tarball/master" |  tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify




USER user 

ADD index.html  /opt/noVNC/
ADD supervisord.conf /opt/
CMD /usr/bin/supervisord -n -c /opt/supervisord.conf
