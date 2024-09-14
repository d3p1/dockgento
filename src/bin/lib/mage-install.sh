#!/bin/bash

##
# @description Dockgento command to install a Magento platform
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
	_install_magento_platform
}

##
# Install Magento platform
#
# @return void
# @note   Install Magento using Composer installation process
# @note   It is used `docker compose run cli` instead of `docker compose up cli`
#         to be able to define command to run (it is not possible to do that
#         using `docker compose up <service>`)
# @link   https://experienceleague.adobe.com/en/docs/commerce-operations/installation-guide/composer
##
_install_magento_platform() {
	##
	# @note In order to install a Magento platform,
	#       the Redis, MariaDB and other resources should be running,
	#       to avoid Magento exceptions during installation
	# @note The `cli` service uses the project PHP CLI image.
	#       This image has an `init` script that receives as first param
	#       a flag to determine if it is required to execute an installation.
	#       If it is set to `true`, then a Magento platform installation is
	#       executed. If it is set to `false`, then a Magento setup is executed
	# @link https://hub.docker.com/r/d3p1/magento-php
	##
	print_message "Start Magento installation" "notice"
	docker compose up -d
	docker compose run --rm cli init 1
	print_message "End Magento installation" "notice"
}

##
# @note Call main
##
main "$@"