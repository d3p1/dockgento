#!/bin/bash

##
# @description Dockgento command to configure a Magento platform
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/execute-command-script.sh

##
# Main
#
# @return void
##
main() {
    _execute_configure_script "configure-services"
}

##
# Execute configure script
#
# @param  string $1 Script name
# @return void
##
_execute_configure_script() {
    execute_command_script "$BASE_DIR/lib/mage-configure" "$1" "$SCRIPT_MODE"
}

##
# @note Call main
##
main "$@"