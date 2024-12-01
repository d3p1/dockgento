#!/bin/bash

##
# @description An utility to log messages in terminal
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Print environment variable name and value in terminal using specific format
#
# @param  string $1 Environment variable name
# @return void
##
print_env_var() {
    print_message "\`$1\`: ${!1}" "notice"
}

##
# Print message in terminal using specific format
#
# @param  string $1 Text
# @param  string $2 Message type.
#                   Could be: `error`, `notice`, `success` and `normal`.
#                   By default is `normal`
# @return void
# @link   https://dev.to/ifenna__/adding-colors-to-bash-scripts-48g4
##
print_message() {
    ##
    # @note Define message type format
    ##
    local notice_format="\e[3;33m"
    local success_format="\e[32m"
    local error_format="\e[31m"
    local reset_format="\e[0m"

    ##
    # @note Evaluate message type
    ##
    local type
    if [ -z "$2" ]; then
        type="normal"
    else
        type="$2"
    fi

    ##
    # @note Print message
    ##
    case "$type" in
        notice)
            echo -e "${notice_format}[NOTICE] $1${reset_format}"
        ;;

        success)
            echo -e "${success_format}[SUCCESS] $1${reset_format}"
        ;;

        error)
            echo -e "${error_format}[ERROR] $1${reset_format}"
        ;;

        *)
            echo -e "$1\n"
        ;;
    esac;
}