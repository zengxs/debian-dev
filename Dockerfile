FROM debian:bookworm

LABEL maintainer="Charlie Tseng"

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        systemd \
        systemd-sysv \
        dbus \
        sudo \
        zsh \
        openssh-server \
        vim \
        curl \
        wget \
        git \
        openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -m -s /bin/zsh -u $USER_UID -g $USER_GID -G sudo $USERNAME \
    && echo "$USERNAME:$USERNAME" | chpasswd \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

ENV container=oci

RUN systemctl enable ssh
RUN systemctl mask systemd-logind

CMD ["/sbin/init"]
STOPSIGNAL SIGRTMIN+3
