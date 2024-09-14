#!/bin/bash

##
# @description Dockgento init command
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/execute-script.sh

##
# Main
#
# @param  string $1 Environment to initialize
# @return void
##
main() {
	##
	# @note Validate input params
	##
	_validate "$@"

	##
	# @note Execute script to install required dependencies in host machine
	##
	_execute_init_script "install-dependencies" "$1"

	##
	# @note Execute script to implement required configurations in host machine
	##
	_execute_init_script "configure-host" "$1"

    ##
	# @note Execute script to configure (Docker Compose) services
	# @note In this script will be exported the
    #       respective environment variables that
    #       will be persisted by the `deploy` script
    #       in the respective env files using the `envsubst` command
	##
	_execute_init_script "configure-services" "$1"

	##
	# @note Execute script to deploy environment.
	#       It will be created the respective Docker Compose files
	#       with the respective environment files in the current directory,
	#       so the user can run the environment on demand
	#       with `docker compose up -d` command
	##
	_execute_init_script "deploy" "$1"
}

##
# Execute init script
#
# @param  string $1 Script name
# @param  string $2 Environment to initialize
# @return void
# @note   It is executed the common init script and a custom one that could
#         exist for the given environment
##
_execute_init_script() {
	local common_script
	local env_script
	local base_path

	base_path="$BASE_DIR/lib/init"
	common_script="$base_path/$1.sh"
	env_script="$base_path/$2/$1.sh"

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

##
# Validate
#
# @param  string $1 Environment to initialize
# @return void
##
_validate() {
	if [ "$1" != "development" ] && [ "$1" != "production" ]; then
		print_message "You should specified \`\"development\"\` or \`\"production\"\` as argument to define which type of environment initialize" "error"
		exit 1
	fi
}

##
# @note Call main
##
main "$@"