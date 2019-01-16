FROM ksmster/ubuntu-xvfb-novnc:latest

USER root
RUN apt-get update && apt-get -y install \
    gedit \
    && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

