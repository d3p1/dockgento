#!/bin/bash

##
# @description Install development dependencies required for `dockgento init`
#              and the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/mkcert/install.sh

##
# Main
# 
# @return void
##
main() {
    _install_mkcert
}

##
# Install `mkcert` to generate locally-trusted SSL certificates
#
# @return void
# @link   https://github.com/FiloSottile/mkcert
##
_install_mkcert() {
    ##
    # @note Check if `mkcert` is already installed
    ##
    if [ -z "$(which mkcert)" ]; then
        print_message "Start \`mkcert\` installation" "notice"
        install_mkcert
        print_message "End \`mkcert\` installation" "notice"
    else
        print_message "\`mkcert\` is already installed in the system" "notice"
    fi
}

##
# @note Call main
##
main "$@"