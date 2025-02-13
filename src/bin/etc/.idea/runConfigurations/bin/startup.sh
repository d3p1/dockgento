#!/bin/bash

##
# @description Startup script
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Add flag to exit script if there is an error related to a command
##
set -e

##
# @note Init global variables
##
declare BASE_DIR
BASE_DIR="$(dirname "${BASH_SOURCE[0]}")"

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/exec-docker-compose-environment.sh
source $BASE_DIR/lib/utils/sleep-random-secs.sh

##
# Main
#
# @return void
##
main() {
    ##
    # @note Check if command is executed inside the Docker Compose environment directory
    ##
    if [ ! -e "docker-compose.yml" ]; then
        echo "This command should be executed inside the Docker Compose environment directory"
        exit 1
    fi

    ##
    # @note Execute Docker Compose environment if it is not running
    # @note A hotfix has been implemented to prevent multiple startup scripts
    #       from initializing the environment simultaneously.
    #       Since these scripts run at the "same" time, they do not know
    #       whether another script has already started the
    #       initialization process. To mitigate this, each script sleeps
    #       for a random duration (between 1 and 10 seconds),
    #       increasing the likelihood that the environment
    #       is properly initialized before execution
    # @todo Improve this behaviour
    ##
    sleep_random_secs "10"
    exec_docker_compose_environment

    ##
    # @note Validate command to execute
    ##
    case "$1" in
        dev | cache)
            _execute_command "$1"
            ;;

        *)
            echo "The startup command does not exist."
            ;;
    esac

    exit 0
}

##
# Execute command
#
# @param  string $1 Command name
# @return void
##
_execute_command() {
    . "$BASE_DIR/lib/$1.sh"
}

##
# @note Call main
##
main "$@"