#!/bin/bash

##
# @description Utilities to configure Docker
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @todo        For now, this utility only works with Debian
##

##
# Implement a basic configuration for Docker
#
# @return void
# @link   https://docs.docker.com/engine/install/linux-postinstall/
##
configure_docker() {
    ##
    # @note Add user to `docker` group so it is possible to execute `docker`
    #       without `sudo`
    ##
    sudo usermod -aG docker "$USER"
}

##
# Configure rootless mode for Docker
#
# @return void
# @todo   For now, this function does not work for Debian 10 because,
#         for this distro version, it is necessary to add
#         `kernel.unprivileged_userns_clone=1` to
#         `etc/sysctl.conf` (or `/etc/sysctl.d`) and run
#         `sudo sysctl --system`
# @link   https://docs.docker.com/engine/security/rootless/
# @link   https://docs.docker.com/engine/security/rootless/#distribution-specific-hint
##
configure_docker_rootless_mode() {
    ##
    # @note Install required dependencies
    ##
    sudo apt-get install -y libsubid4
    sudo apt-get install -y uidmap
    sudo apt-get install -y dbus-user-session
    sudo apt-get install -y fuse-overlayfs
    sudo apt-get install -y slirp4netns

    ##
    # @note Disable daemon
    ##
    sudo systemctl disable --now docker.service docker.socket

    ##
    # @note Define and export `XDG_RUNTIME_DIR` just in case it is not defined.
    #       In this way, it is avoided errors during
    #       `dockerd-rootless-setuptool.sh install` like
    #       `systemd not detected` and
    #       `Failed to connect to bus: No such file or directory`.
    #       This issue only happens when you switch to user using
    #       `sudo` or `su`, because in this situation,
    #       all needed hooks to use `systemctl` are not configured correctly
    # @link https://github.com/docker/docs/issues/14491
    # @link https://unix.stackexchange.com/questions/587674/systemd-not-detected-dockerd-daemon-needs-to-be-started-manually
    ##
    XDG_RUNTIME_DIR="/run/user/$(id -u)"
    export XDG_RUNTIME_DIR

    ##
    # @note Configure daemon as rootless mode
    ##
    dockerd-rootless-setuptool.sh install --force

    ##
    # @note Enable daemon in rootless mode
    ##
    systemctl --user start docker

    ##
    # @note Enable daemon so it starts every time the host machine starts
    ##
    systemctl --user enable docker
    sudo loginctl enable-linger "$(whoami)"

    ##
    # @note Export and persist env variables with new docker socket information,
    #       so client knows how to communicate with it
    ##
    PATH="/usr/bin:$PATH"
    DOCKER_PATH="$XDG_RUNTIME_DIR/docker.sock"
    DOCKER_HOST="unix://$DOCKER_PATH"
    echo "# Docker rootless mode configuration (https://docs.docker.com/engine/security/rootless/#install)" | tee -a ~/.bashrc
    echo "export PATH=$PATH" | tee -a ~/.bashrc
    echo "export DOCKER_PATH=$DOCKER_PATH" | tee -a ~/.bashrc
    echo "export DOCKER_HOST=$DOCKER_HOST" | tee -a ~/.bashrc
    source ~/.bashrc

    ##
    # @note Enable the possibility to map privileged ports (like `80` or `443`)
    ##
    sudo setcap cap_net_bind_service=ep "$(which rootlesskit)"
    systemctl --user restart docker
}