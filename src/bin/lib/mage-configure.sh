#!/bin/bash

##
# @description Dockgento command to configure a Magento platform
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/execute-command-script.sh

##
# Main
#
# @return void
##
main() {
    ##
    # @note In order to configure a Magento platform,
    #       the Redis, MariaDB and other resources should be running,
    #       to avoid Magento exceptions
    ##
    docker compose up -d

    ##
    # @note Before executing the script that configure a Magento platform,
    #       it is required to prepare the environment services to meet
    #       conditions needed for a Magento configuration
    ##
    _execute_configure_script "configure-services"

    ##
    # @note The `cli` service uses the project PHP CLI image.
    #       This image has an `init` script that receives as first param
    #       a flag to determine if it is required to execute an installation.
    #       If it is set to `true`, then a Magento platform installation is
    #       executed. If it is set to `false`, then a Magento set up
    #       action is executed
    # @note It is used `docker compose run cli`
    #       instead of `docker compose up cli`
    #       to be able to define command to run (it is not possible to do that
    #       using `docker compose up <service>`)
    # @link https://hub.docker.com/r/d3p1/magento-php
    ##
    docker compose run --rm cli init 0
}

##
# Execute configure script
#
# @param  string $1 Script name
# @return void
##
_execute_configure_script() {
    execute_command_script "$BASE_DIR/lib/mage-configure" "$1" "$SCRIPT_MODE"
}

##
# @note Call main
##
main "$@"