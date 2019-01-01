FROM ubuntu:18.04



WORKDIR "/src"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV LC_MESSAGES C.UTF-8
ENV LANGUAGE C.UTF-8
ENV GCC_VER=8
ENV LLVM_VER=7
ENV DEBIAN_FRONTEND noninteractive

# Paper over occasional network flakiness of some mirrors.
RUN echo 'Acquire::Retries "10";' > /etc/apt/apt.conf.d/80retry

# Do not install recommended packages
RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/80recommends

# Do not install suggested packages
RUN echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf.d/80suggests

# Assume yes
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/80forceyes

# Fix broken packages
RUN echo 'APT::Get::Fix-Missing "true";' > /etc/apt/apt.conf.d/80fixmissin

# Install general build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        mc \
        curl \
        wget \
        libgtk-3-bin


# Configure broadwayd
ENV GDK_BACKEND broadway
ENV BROADWAY_DISPLAY :5
EXPOSE 8080
CMD broadwayd -p 8080 -a 0.0.0.0 :5