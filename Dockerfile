FROM docker.io/library/debian:12
ENV PYTHON_VERSION=3.11.*

# https://raw.githubusercontent.com/lean-delivery/docker-systemd/master/Dockerfile-ubuntu-22.04
LABEL maintainer="team@lean-delivery.com"

ENV container=docker \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm \
    DEBIAN_FRONTEND="noninteractive"

RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -print0 | xargs -0 rm -vf

RUN apt-get update && \
    INSTALL_PKGS="python3 sudo bash apt-utils locales iproute2 locales ca-certificates dbus gnupg systemd" && \
    apt-get install -y $INSTALL_PKGS && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -f UTF-8 -i en_US en_US.UTF-8

RUN apt-get update -y && \
    apt-get install -y python3=$PYTHON_VERSION &&  \
    rm -rf /var/lib/apt/lists/*
    
RUN cp /bin/true /sbin/agetty

STOPSIGNAL SIGRTMIN+3

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
