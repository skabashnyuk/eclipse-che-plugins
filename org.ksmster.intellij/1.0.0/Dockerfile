FROM ksmster/ubuntu-xvfb-novnc:latest

USER root
RUN apt-get update && apt-get -y install \
    openjdk-8-jdk \
    && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN wget -q -O /tmp/intellij.tar.gz https://download.jetbrains.com/idea/ideaIC-2018.3.3-no-jdk.tar.gz && \
    echo 'Installing IntelliJ IDEA' && \
    mkdir -p /opt/intellij && \
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij && \
    rm /tmp/intellij.tar.gz
RUN rm /opt/app_to_launch && echo "/opt/intellij/bin/idea.sh && tail -f /dev/null" >> /opt/app_to_launch && chmod +x /opt/app_to_launch

USER user