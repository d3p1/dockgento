#!/bin/bash

##
# @description Dockgento.
#              Install, setup and deploy a Docker environment for Magento 2
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Add flag to exit script if there is an error related to a command
##
set -e

##
# @note Init global/environment variables that could be useful 
#       for called commands/scripts
##
declare BASE_DIR
BASE_DIR=$(dirname "${BASH_SOURCE[0]}")
export BASE_DIR

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/execute-script.sh

##
# Main
#
# @param  string $1 Command to run
# @param  string $2 Command parameters
# @return void
##
main() {
	case "$1" in
		init | mage-install | mage-setup)
			_execute_command "$@"
			;;

		*)
			_print_help
			;;
	esac

	exit 0
}

##
# Execute command
#
# @param  string $1 Command name
# @param  string $2 Command params
# @return void
# @note   In reality, the `shift` command and
#         the `@` symbol (as a rest operator) are used to retrieve
#         command parameters. Consequently, every argument
#         following the `$1` parameter (command name)
#         is treated as part of `$2`, and will be used as a command parameter
##
_execute_command() {
    local script

	##
	# @note Execute script
	# @note Check script execution.
	#       If the returned status is different from success,
	#       then display help message
	##
    script="$BASE_DIR/lib/$1.sh"
    shift
    if ! execute_script "$script" "$@"; then
		_print_help
	fi
}

##
# Print help message
#
# @return void
##
_print_help() {
	print_message \
	"Usage:" \
	" - To init a Docker environment: \`dockgento init <env>\`" \
	" - To install a Magento platform: \`dockgento mage-install\`" \
	" - To setup a Magento platform: \`dockgento mage-setup\`" \
	"[NOTICE] Before using this script, remember to configure the \`.dockgento_profile\` file"
}

##
# @note Call main
##
main "$@"