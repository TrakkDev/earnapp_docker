FROM ubuntu:24.04

LABEL maintainer="TrakkDev"
ENV container=docker

HEALTHCHECK --interval=1m --timeout=10s --start-period=10s --retries=2 CMD cat /etc/earnapp/status | grep enabled && exit 0 || exit 1
VOLUME [ "/etc/earnapp" ]

RUN apt-get update \
    && apt-get install -y wget sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app

COPY src src
RUN cp /app/src/install.sh /usr/bin/install \
    && printf '#!/bin/bash \n echo "%s"' "$(lsb_release -a)" > /usr/bin/lsb_release \
    && printf '#!/bin/bash \n echo "%s"' "$(hostnamectl)" > /usr/bin/hostnamectl \
    && printf '#!/bin/bash \n echo "%s"' "$(systemctl)" > /usr/bin/systemctl \
    && chmod a+x /usr/bin/install /usr/bin/hostnamectl /usr/bin/lsb_release /usr/bin/systemctl

# Install earnapp with sudo package
RUN "install"

# remove sudo from image
RUN export SUDO_FORCE_REMOVE=yes && dpkg --purge sudo && \
    rm -rf /var/lib/apt/lists/*

CMD ["install"]
