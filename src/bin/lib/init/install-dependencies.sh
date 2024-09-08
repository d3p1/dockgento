#!/bin/bash

##
# @description Install dependencies required for `dockgento init` and
#              the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/print-message.sh
source $BASE_DIR/lib/utils/docker/install.sh

##
# Main
#
# @return void
# @note   Install `docker`
##
main() {
    _install_docker
}

##
# Install `docker`
#
# @return void
##
_install_docker() {
    ##
    # @note Check if `docker` is already installed
    ##
    if [ -z "$(which docker)" ]; then
        print_message "[NOTICE] Start \`docker\` installation"
        install_docker
        print_message "[NOTICE] End \`docker\` installation"
    else
		print_message "[NOTICE] \`docker\` is already installed in the system"
	fi
}

##
# @note Call main
##
main "$@"