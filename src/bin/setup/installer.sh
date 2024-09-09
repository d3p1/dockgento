#!/bin/bash

##
# @description Dockgento installer
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Add flag to exit script if there is an error related to a command
#       or if it is used an undefined variable
##
set -eu

##
# @note Init global variables
##
declare CURRENT_DIR
declare CLI_DIR
CURRENT_DIR="$(pwd)"
CLI_DIR="$HOME/bin/dockgento"

##
# Main
#
# @return void
##
main() {
    ##
    # @note Check if script is already installed
    # @note If script is already installer, it is removed so it can be
    #       downloaded and configured a new version
    ##
    if [ -d "$CLI_DIR" ]; then
		rm -rf "$CLI_DIR"
	fi

	##
	# @note Setup CLI
	##
	_setup_cli

	##
	# @note Install CLI
	##
	_install_cli

	##
	# @note Persist CLI in `PATH` environment variable
	##
	_add_shell_command

	##
	# @note Add success message
	##
	_print_message "[NOTICE] \`dockgento\` was successfully installed "

    exit 0;
}

##
# Setup `dockgento`
#
# @return void
##
_setup_cli() {
	_print_message "[NOTICE] Start CLI dir creation: $CLI_DIR"
	mkdir -p "$CLI_DIR" && cd "$CLI_DIR"
	_print_message "[NOTICE] End CLI dir creation: $CLI_DIR"
}

##
# Install `dockgento`
#
# @return void
##
_install_cli() {
	_print_message "[NOTICE] Start CLI installation"
	cp "$CURRENT_DIR/../dockgento.sh" dockgento && chmod u+x dockgento
	cp -R "$CURRENT_DIR/../lib/" . && chmod -R +x ./lib/
	cp -R "$CURRENT_DIR/../etc/" .
	_print_message "[NOTICE] End CLI installation"
}

##
# Add `dockgento` as a shell command
#
# @return void
##
_add_shell_command() {
	local current_profile

	_print_message "[NOTICE] Start add \`dockgento\` to commands"

	##
	# @note Get user profile
	# @note If `.bash_profile` does not exist, get content from `.profile`
	#       and create `.bash_profile` with this content
	# @note Remove `PATH` definition from user profile
	#       to be able to update it in a cleaner way
	##
	current_profile=""
	if [ ! -e "$HOME/.bash_profile" ]; then
		touch "$HOME/.bash_profile"
		current_profile="$(sed '/export PATH/d' "$HOME/.profile")"
	else
		current_profile="$(sed '/export PATH/d' "$HOME/.bash_profile")"
	fi

	##
	# @note Persist CLI inside `PATH` environment variable to be able to use
	#       it as a command
	##
	printf \
	"%s\n" \
	"$current_profile" \
	"export PATH=$CLI_DIR:$PATH" > "$HOME/.bash_profile"

	_print_message "[NOTICE] End add \`dockgento\` to commands"
}

##
# Print message
#
# @param  string $1 Message
# @return void
##
_print_message() {
	printf "%s\n" "$1"
}

##
# @note Call main
##
main "$@"