FROM alexl/broadway

USER root 
ENV HOME=/home/user
WORKDIR ${HOME}
RUN  echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
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
ADD init.sh /