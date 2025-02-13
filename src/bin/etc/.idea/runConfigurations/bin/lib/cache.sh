#!/bin/bash

##
# @description Execute cache watcher
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Main
#
# @return void
##
main() {
    docker compose run --rm -it --user=www cli /composer/vendor/bin/cache-clean.js --watch
}

##
# @note Call main
##
main "$@"