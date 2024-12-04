#!/bin/sh

##
# @description Docker entrypoint
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Add flag to exit script if there is an error related to a command
#       or if it is used an undefined variable
##
set -e

##
# Main
#
# @return void
##
main() {
    ##
    # @note Configure Composer
    ##
    _configure_composer
    
    ##
    # @note Execute base image entry point
    # @note It is used `exec` to avoid the creation of a subshell
    #       and run the command as the main process 
    #       (in this way, it is possible to send signals to this process)
    ##
    exec /docker-entrypoint.sh "$@" 
}

##
# Configure Composer
#
# @return void
# @link   https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/cli/docker-entrypoint.sh
##
_configure_composer() {
    if [ -n "$COMPOSER_VERSION" ]; then 
        composer self-update "$COMPOSER_VERSION"
    fi
    if [ -n "$COMPOSER_GITHUB_TOKEN" ]; then
        composer config \
                --global \
                github-oauth.github.com \
                "$COMPOSER_GITHUB_TOKEN"
    fi
    if [ -n "$COMPOSER_MAGENTO_USERNAME" ]; then
        composer config \
                 --global \
                 http-basic.repo.magento.com \
                 "$COMPOSER_MAGENTO_USERNAME" \
                 "$COMPOSER_MAGENTO_PASSWORD"
    fi
}

##
# @note Execute main function
##
main "$@"