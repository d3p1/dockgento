#!/bin/bash

##
# @description Utility command to execute Docker Compose environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Execute Docker Compose environment
#
# @return void
##
exec_docker_compose_environment() {
    ##
    # @note If environment is not up, then execute environment
    ##
    if ! _is_docker_compose_up; then
        ##
        # @note It is not required to define Docker Compose files because
        #       they are already defined in the `.env` file and the
        #       `COMPOSE_FILE` environment variable
        ##
        docker compose up -d
    fi
}

##
# @note Check if Docker Compose environment is up
#
# @return int
##
_is_docker_compose_up() {
    ##
    # @note If one service is up, then it is considered that
    #       the environment is up
    ##
    docker compose ps | grep -q "Up"
}