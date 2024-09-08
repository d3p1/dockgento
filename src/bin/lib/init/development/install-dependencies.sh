#!/bin/bash

##
# @description Install development dependencies required for `dockgento init`
#              and the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/print-message.sh
source $BASE_DIR/lib/mkcert/install.sh

##
# Main
# 
# @return void
# @note   Install `mkcert` to generate locally-trusted SSL certificates
##
main() {
    _install_mkcert
}

##
# Install `mkcert` tool
#
# @return void
# @link   https://github.com/FiloSottile/mkcert
##
_install_mkcert() {
    ##
    # @note Check if `mkcert` is already installed
    ##
    if [ -z "$(which mkcert)" ]; then
        print_message "[NOTICE] Start \`mkcert\` installation"
        install_mkcert
        print_message "[NOTICE] End \`mkcert\` installation"
	else
		print_message "[NOTICE] \`mkcert\` is already installed in the system"
    fi    
}

##
# @note Call main
##
main "$@"