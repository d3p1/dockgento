#!/bin/bash

##
# @description An utility to print message in terminal
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Print message in terminal using specific format (each message/text received is
# separated by a new line and printed)
#
# @param  string $1 Message
# @return void
# @note   In reality, the `@` symbol (as a rest operator) is used to retrieve
#         script parameters. Consequently, every argument is treated
#         as part of `$1`, and will be used as a script parameter
##
print_message() {
    printf "%s\n" "$@"
}