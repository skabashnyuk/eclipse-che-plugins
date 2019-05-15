FROM ksmster/ubuntu-xvfb-novnc:latest

USER root
RUN apt-get update && apt-get -y install \
    gedit \
    && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN rm /opt/app_to_launch && echo "gedit && tail -f /dev/null" >> /opt/app_to_launch && chmod +x /opt/app_to_launch
USER user