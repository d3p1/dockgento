#!/bin/bash

##
# @description An utility to install Docker tools
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @todo        For now, this utility only works with Debian
# @todo        Analyze why first attempt of installation always fails
##

##
# Install Docker
#
# @return void
# @link   https://docs.docker.com/engine/install/debian/
##
install_docker() {
        ##
        # @note Install required dependencies
        ##
        sudo apt-get update
        sudo apt-get install \
            ca-certificates \
            curl \
            gnupg

        ##
        # @note Configure repository
        ##
        _configure_docker_repo

        ##
        # @note Install tools
        ##
        _install_docker_tools
}

##
# Configure Docker repository
#
# @return void
##
_configure_docker_repo() {
    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

##
# Install Docker tools
#
# @return void
##
_install_docker_tools() {
    sudo apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin
}