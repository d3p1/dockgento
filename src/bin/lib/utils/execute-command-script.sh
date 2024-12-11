#!/bin/bash

##
# @description An utility to execute scripts related to a
#              `dockgento` command
#              like `init`, `mage-install`, `mage-setup`, etc.
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source log.sh
source execute-script.sh

##
# Execute command script
#
# @param  string $1 Command path
# @param  string $2 Script name
# @param  string $3 Environment
# @return void
# @note   It is executed the common command script and a custom one that could
#         exist for the given environment
##
execute_command_script() {
    local common_script
    local env_script

    common_script="$1/$2.sh"
    env_script="$1/$3/$2.sh"

    _process_init_script_execution "$common_script"
    _process_init_script_execution "$env_script"
}

##
# Process init script execution
#
# @param  string $1 Script path
# @return void
##
_process_init_script_execution() {
    if [ -e "$1" ]; then
        print_message "Start execution of $1" "notice"
        execute_script "$1"
        print_message "End execution of $1" "notice"
    fi
}