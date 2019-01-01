ARG UBUNTU_VERSION=bionic
FROM ubuntu:${UBUNTU_VERSION}

# development libraries
RUN apt-get update

# libgtk-3-0 (gtk runtime) and broadway daemon (libgtk-3-bin)
RUN apt-get install -y --no-install-recommends libgtk-3-0 libgtk-3-bin gtk-3-examples openjdk-8-jdk wget

# remove package lists and cache to keep image small...
RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN echo "Downloading Eclipse" \
    && cd /root && wget -O- "http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/2018-09/R/eclipse-java-2018-09-linux-gtk-x86_64.tar.gz" | tar xz \
    && mkdir /projects && \
    for f in "/etc" "/var/run" "/projects" "/root"; do \
           chgrp -R 0 ${f} && \
           chmod -R g+rwX ${f}; \
       done


COPY broadway-gtk3-demo.sh /usr/local/bin/broadway-gtk3-demo

EXPOSE 8085

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/usr/local/bin/broadway-gtk3-demo"]
