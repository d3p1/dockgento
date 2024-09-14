#!/bin/bash

##
# @description An utility to execute scripts
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Execute script
#
# @param  string $1 Script path
# @param  string $2 Script params
# @return void
# @note   In reality, the `shift` command and
#         the `@` symbol (as a rest operator) are used to retrieve
#         script parameters. Consequently, every argument
#         following the `$1` parameter (script path) is treated as part of `$2`,
#         and will be used as a script parameter
##
execute_script() {
    local script

    ##
    # @note It is used "dot space script" calling syntax 
    #       (it is like `source` command), so it is used current shell to
    #       execute the script (and it is not created a sub-shell that avoids
    #       the use/definition of environment variables
    #       from/to the main shell script).
    #       It is not possible to use the `exec` command because this command
    #       replace main shell script (instead of reusing it), so when the
    #       executed script tries to return to main shell script, it does not
    #       exist and the script terminates unexpectedly
    # @link https://stackoverflow.com/questions/496702/can-a-shell-script-set-environment-variables-of-the-calling-shell
    # @link https://stackoverflow.com/questions/16618071/can-i-export-a-variable-to-the-environment-from-a-bash-script-without-sourcing-i
    ##
    script=$1
    shift
    . "$script" "$@"
}