#!/bin/bash

##
# @description An utility to log messages in terminal
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Print message in terminal using specific format
#
# @param  string $1 Texts
# @return void
# @note   The `@` symbol (as a rest operator) is used to retrieve
#         received texts. Consequently, every argument/text is treated
#         as part of `$1`, and will be used to form the message
##
print_message() {
    printf "%s\n" "$@"
}

##
# Print environment variable name and value in terminal using specific format
#
# @param  string $1 Environment variable name
# @return void
##
print_env_var() {
	print_message "[NOTICE] \`$1\`: ${!1}"
}