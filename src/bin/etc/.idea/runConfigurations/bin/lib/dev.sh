#!/bin/bash

##
# @description Execute container for development purpose
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Main
#
# @return void
##
main() {
    docker compose run --rm -it --user=www -v ~/.ssh/:/home/www/.ssh/ -v ~/.gitconfig:/home/www/.gitconfig cli /bin/bash
}

##
# @note Call main
##
main "$@"