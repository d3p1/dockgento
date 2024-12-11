#!/bin/bash

##
# @description Dockgento init command
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
    # @note Validate environment
    ##
    _validate

    ##
    # @note Execute script to install required dependencies in host machine
    ##
    _execute_init_script "install-dependencies"

    ##
    # @note Execute script to implement required configurations in host machine
    ##
    _execute_init_script "configure-host"

    ##
    # @note Execute script to configure (Docker Compose) services
    # @note In this script will be exported the
    #       respective environment variables that
    #       will be persisted by the `deploy` script
    #       in the respective env files using the `envsubst` command
    ##
    _execute_init_script "configure-services"

    ##
    # @note Execute script to deploy environment.
    #       It will be created the respective Docker Compose files
    #       with the respective environment files in the current directory,
    #       so the user can run the environment on demand
    #       with `docker compose up -d` command
    ##
    _execute_init_script "deploy"
}

##
# Execute init script
#
# @param  string $1 Script name
# @return void
##
_execute_init_script() {
    execute_command_script "$BASE_DIR/lib/init" "$1" "$SCRIPT_MODE"
}

##
# Validate
#
# @return void
##
_validate() {
    if [ "$SCRIPT_MODE" != "development" ] && [ "$SCRIPT_MODE" != "production" ]; then
        print_message "You should specify \`\"development\"\` or \`\"production\"\` as the \`SCRIPT_MODE\` to define which type of environment to initialize" "error"
        exit 1
    fi
}

##
# @note Call main
##
main "$@"