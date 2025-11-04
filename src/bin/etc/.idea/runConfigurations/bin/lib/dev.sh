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
    ##
    # @note It is shared Git configuration (like author information),
    #       to avoid having to define it again in the container
    #       while using Git
    # @note It is mounted the SSH agent socket (`$SSH_AUTH_SOCK`)
    #       to the container. In that way, we can use it to
    #       execute SSH connections to our trusted hosts
    #       without sharing our private keys.
    #       This is useful to work with SSH repositories
    ##
    docker compose run --rm -it --user=www -v ~/.gitconfig:/home/node/.gitconfig -v ${SSH_AUTH_SOCK}:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent cli /bin/bash
}

##
# @note Call main
##
main "$@"