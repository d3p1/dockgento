#!/bin/bash

##
# @description An utility to install `mkcert`
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @todo        For now, this utility only works with Debian
##

##
# Install `mkcert`
#
# @return void
# @link   https://github.com/FiloSottile/mkcert
##
install_mkcert() {
    ##
    # @note Download in `/tmp` folder and return to current location (`cd -`)
    # @link https://stackoverflow.com/questions/16362402/save-file-to-specific-folder-with-curl-command
    ##
    cd /tmp                                                         && \
    curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64" && \
    chmod +x mkcert-v*-linux-amd64                                  && \
    sudo cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert             && \
    cd - || exit 1

    ##
    # @note Install CA
    ##
    mkcert -install
}