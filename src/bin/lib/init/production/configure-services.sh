#!/bin/bash

##
# @description Configure `dockgento init` production services
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh

##
# Main
#
# @return void
##
main() {
    ##
	# @note Export required environment variables for Traefik
	##
	_configure_traefik

	##
	# @note Export required environment variables for Magento
	#       (and PHP related services)
	##
	_configure_magento

	##
	# @note Export required environment variables for Docker Compose
	##
	_configure_compose
}

##
# Configure Traefik
#
# @return void
# @note   It is used the `DOCKER_PATH` environment variable exposed by the
#         `docker` rootless mode configuration to define
#         `docker` daemon socket location. This environment variable
#         defines the new socket that should be used to comunicate with
#         `docker` daemon in rootless mode
# @note   The `docker` socket is mounted in Traefik service so it can work
#         with the infrastructure
#         (i.e.: it allows the recognition of available services)
##
_configure_traefik() {
	print_message "[NOTICE] Start init Traefik prod environment variables"
    SCRIPT_DOCKER_PATH="$DOCKER_PATH"
    export SCRIPT_DOCKER_PATH
    print_env_var "SCRIPT_DOCKER_PATH"
    print_message "[NOTICE] End init Traefik prod environment variables"
}

##
# Configure Magento (and related PHP services)
#
# @return void
##
_configure_magento() {
	print_message "[NOTICE] Start init Magento prod environment variables"
	SCRIPT_PHP_SENDMAIL_PATH="/dev/null"
	SCRIPT_MAGENTO_RUN_MODE="production"
	export SCRIPT_PHP_SENDMAIL_PATH
	export SCRIPT_MAGENTO_RUN_MODE
	print_env_var "SCRIPT_PHP_SENDMAIL_PATH"
	print_env_var "SCRIPT_MAGENTO_RUN_MODE"
	print_message "[NOTICE] End init Magento prod environment variables"
}

##
# Configure Docker Compose
#
# @return void
# @note   It is defined the `SCRIPT_COMPOSE_FILE` (used for the `COMPOSE_FILE`)
#         to determine the Docker Compose files to use
#         when `docker compose up -d` is executed
##
_configure_compose() {
	print_message "[NOTICE] Start init Docker Compose prod environment variables"
	SCRIPT_COMPOSE_FILE="docker-compose.yml:docker-compose.prod.yml:services/search/${SCRIPT_SEARCH_SERVICE}/docker-compose.yml"
	export SCRIPT_COMPOSE_FILE
	print_env_var "SCRIPT_COMPOSE_FILE"
	print_message "[NOTICE] End init Docker Compose prod environment variables"
}

##
# @note Call main
##
main "$@"