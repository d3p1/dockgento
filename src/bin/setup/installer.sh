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
declare BASE_DIR
declare CLI_DIR
BASE_DIR="$(dirname "${BASH_SOURCE[0]}")"
CLI_DIR="$HOME/bin/dockgento"

##
# @note Import required utilities
##
source $BASE_DIR/../lib/utils/log.sh

##
# Main
#
# @return void
##
main() {
    ##
    # @note Check if script is already installed
    # @note If script is already installed, it is removed so it can be
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
    print_message "\`dockgento\` was successfully installed " "success"

    exit 0;
}

##
# Setup `dockgento`
#
# @return void
##
_setup_cli() {
    print_message "Start CLI dir creation: $CLI_DIR" "notice"
    mkdir -p "$CLI_DIR"
    print_message "End CLI dir creation: $CLI_DIR" "notice"
}

##
# Install `dockgento`
#
# @return void
##
_install_cli() {
    print_message "Start CLI installation" "notice"
    cp "$BASE_DIR/../dockgento.sh" "$CLI_DIR/dockgento"
    chmod u+x "$CLI_DIR/dockgento"
    cp -R "$BASE_DIR/../lib/" "$CLI_DIR" && chmod -R +x "$CLI_DIR/lib/"
    cp -R "$BASE_DIR/../etc/" "$CLI_DIR"
    print_message "End CLI installation" "notice"
}

##
# Add `dockgento` as a shell command
#
# @return void
##
_add_shell_command() {
    local current_profile

    print_message "Start add \`dockgento\` to commands" "notice"

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

    print_message "End add \`dockgento\` to commands" "notice"
}

##
# @note Call main
##
main "$@"