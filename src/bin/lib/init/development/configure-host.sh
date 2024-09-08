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
	##
	# @note Configure `docker`
	##
    _configure_docker

    ##
    # @note Generate locally-trusted SSL certificates
    ##
    _generate_ssl_certificates
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
# Generate SSL certificates
#
# @return void
##
_generate_ssl_certificates() {
    print_message "[NOTICE] Start generation of locally-trusted SSL certificates for domain $SCRIPT_DOMAIN"
    generate_ssl_certificates \
    "magento" \
    "$SCRIPT_DOMAIN" \
    "$BASE_DIR/etc/services/traefik/etc/certs/"
    print_message "[NOTICE] End generation of locally-trusted SSL certificates for domain $SCRIPT_DOMAIN"
}

##
# @note Call main
##
main "$@"