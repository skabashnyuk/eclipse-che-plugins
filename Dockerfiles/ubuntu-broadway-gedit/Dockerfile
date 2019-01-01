FROM ksmster/ubuntu-broadway-base


RUN apt-get update && apt-get install -y --no-install-recommends \
        libgtk-3-0 libgtk-3-bin gedit \
        dbus \
        dconf-tools build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev

  
RUN echo "Downloading Eclipse" \
    && mkdir /projects && \
    for f in "/etc" "/var/run" "/projects" "/root"; do \
           chgrp -R 0 ${f} && \
           chmod -R g+rwX ${f}; \
       done
WORKDIR /projects
COPY ./init.sh /
ENTRYPOINT [ "/init.sh" ]