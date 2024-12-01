#!/bin/bash

##
# @description Install dependencies required for `dockgento init` and
#              the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/docker/install.sh

##
# Main
#
# @return void
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
        print_message "Start \`docker\` installation" "notice"
        install_docker
        print_message "End \`docker\` installation" "notice"
    else
        print_message "\`docker\` is already installed in the system" "notice"
    fi
}

##
# @note Call main
##
main "$@"