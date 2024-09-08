#!/bin/bash

##
# @description Configure development host machine required for `dockgento init`
#              and the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/print-message.sh
source $BASE_DIR/lib/utils/docker/configure.sh

##
# Main
#
# @return void
##
main() {
    _configure_docker
}

##
# Configure `docker`
#
# @return void
##
_configure_docker() {
    print_message "[NOTICE] Start configuration of \`docker\`"
    configure_docker
    print_message "[NOTICE] End configuration of \`docker\`"
}

##
# @note Call main
##
main "$@"