FROM alpine:3.8

ENV HOME=/home/user
WORKDIR ${HOME}

RUN PACKAGES="ca-certificates git bash" && \
    apk update upgrade --no-cache && apk add --no-cache ${PACKAGES}

ENV HOME=/home/user
WORKDIR ${HOME}
RUN adduser --disabled-password -S -u 1001 -G root -h ${HOME} -s /bin/sh user \
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
USER user           
COPY --chown=user:root filebrowser /home/user/filebrowser
COPY --chown=user:root .filebrowser.json /home/user/.filebrowser.json
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD /home/user/filebrowser