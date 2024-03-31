FROM ubuntu:24.04

LABEL maintainer="TrakkDev"
ENV container=docker

HEALTHCHECK --interval=1m --timeout=10s --start-period=10s --retries=2 CMD cat /etc/earnapp/status | grep enabled && exit 0 || exit 1

RUN apt-get update \
    && apt-get install -y wget dos2unix iputils-ping net-tools htop libatomic1 sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY src src
RUN cp /app/src/install.sh /usr/bin/install
RUN printf '#!/bin/bash \n echo "%s"' "$(lsb_release -a)" > /usr/bin/lsb_release \
    && printf '#!/bin/bash \n echo "%s"' "$(hostnamectl)" > /usr/bin/hostnamectl \
    && printf '#!/bin/bash \n echo "%s"' "$(systemctl)" > /usr/bin/systemctl \
    && chmod a+x /usr/bin/install /usr/bin/hostnamectl /usr/bin/lsb_release /usr/bin/systemctl

VOLUME [ "/etc/earnapp" ]

CMD ["install"]
