FROM ubuntu:latest

LABEL maintainer="TrakkDev"
LABEL org.opencontainers.image.authors="TrakkDev"

ENV container=docker

RUN apt-get update \
    && apt-get install -y wget dos2unix iputils-ping net-tools htop libatomic1 sudo \
    && apt-get clean

WORKDIR /app

COPY src src
RUN cp /app/src/install.sh /usr/bin/install
RUN echo -e "#\!/bin/bash \n echo \"$(lsb_release -a)\"" > /usr/bin/lsb_release
RUN echo -e "#\!/bin/bash \n echo \"$(hostnamectl)\"" > /usr/bin/hostnamectl
RUN echo -e "#\!/bin/bash \n echo \"$(systemctl)\"" > /usr/bin/systemctl
RUN chmod a+x /usr/bin/install
RUN chmod a+x /usr/bin/hostnamectl /usr/bin/lsb_release /usr/bin/systemctl

VOLUME [ "/etc/earnapp" ]

CMD ["install"]

HEALTHCHECK --interval=1m --timeout=10s --start-period=10s --retries=2 CMD cat /etc/earnapp/status | grep enabled && exit 0 || exit 1