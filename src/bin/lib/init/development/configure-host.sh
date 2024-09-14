#!/bin/bash

##
# @description Configure development host machine required for `dockgento init`
#              and the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/docker/configure.sh
source $BASE_DIR/lib/utils/mkcert/generate-ssl-certificates.sh

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

    ##
	# @note Add domain to `/etc/hosts` to be able to access project from
	#       localhost without a DNS proxy configuration
	##
	_add_domain_to_hosts
}

##
# Configure `docker`
#
# @return void
##
_configure_docker() {
    print_message "Start configuration of \`docker\`" "notice"
    configure_docker
    print_message "End configuration of \`docker\`" "notice"
}

##
# Generate SSL certificates
#
# @return void
##
_generate_ssl_certificates() {
	local cert_dir

    print_message "Start generation of locally-trusted SSL certificates for domain $SCRIPT_DOMAIN" "notice"
    cert_dir="$BASE_DIR/etc/services/traefik/etc/certs/"
    mkdir -p "$cert_dir"
    generate_ssl_certificates \
    "magento" \
    "$SCRIPT_DOMAIN" \
    "$cert_dir"
    print_message "End generation of locally-trusted SSL certificates for domain $SCRIPT_DOMAIN" "notice"
}

##
# Add domain to `/etc/hosts`
#
# @return void
# @link   https://github.com/markshust/docker-magento/blob/master/compose/bin/setup-domain
# @link   https://unix.stackexchange.com/questions/464652/is-there-any-difference-between-tee-and-when-using-echo
# @link   https://stackoverflow.com/questions/4749330/how-to-test-if-string-exists-in-file-with-bash
##
_add_domain_to_hosts() {
    if ! grep -q "$SCRIPT_DOMAIN" /etc/hosts; then
    	print_message "Start add domain $SCRIPT_DOMAIN to \`/etc/hosts\`" "notice"
        echo "127.0.0.1 ::1 $SCRIPT_DOMAIN" | sudo tee -a /etc/hosts
        print_message "End add domain $SCRIPT_DOMAIN to \`/etc/hosts\`" "notice"
    fi
}

##
# @note Call main
##
main "$@"