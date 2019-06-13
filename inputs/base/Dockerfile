FROM ubuntu:19.04

ENV LC_ALL=C.UTF-8

RUN echo 'root:root' | chpasswd \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    gnupg2 apt-transport-https ca-certificates \
    sudo zsh \
    curl wget jq sed gpp gawk xz-utils neovim unzip git patch \
    && git config --global http.sslVerify false \
    && usermod -s /usr/bin/zsh root

WORKDIR /root

SHELL ["/usr/bin/zsh", "-c"]

CMD zsh