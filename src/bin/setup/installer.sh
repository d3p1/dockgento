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
# @note The CLI files are installed inside the user data folder, and only
#       its entry point is linked inside a user binary folder that is
#       already part of the `PATH` environment variable
# @note It is defined the legacy CLI folder used by previous versions of
#       this installer, so it can be removed during the installation
# @link https://specifications.freedesktop.org/basedir-spec/latest/
##
declare BASE_DIR
declare CLI_DIR
declare LEGACY_CLI_DIR
declare PATH_MARKER_START
declare PATH_MARKER_END
BASE_DIR="$(dirname "${BASH_SOURCE[0]}")"
CLI_DIR="$HOME/.local/share/dockgento"
LEGACY_CLI_DIR="$HOME/bin/dockgento"
PATH_MARKER_START="# >>> dockgento >>>"
PATH_MARKER_END="# <<< dockgento <<<"

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
    # @note Remove CLI folder used by previous versions of this installer
    ##
    _remove_legacy_cli

    ##
    # @note Configure CLI
    ##
    _configure_cli

    ##
    # @note Install CLI
    ##
    _install_cli

    ##
    # @note Add CLI entry point to a user binary folder inside `PATH`
    ##
    _add_shell_command

    ##
    # @note Add success message
    ##
    print_message "\`dockgento\` was successfully installed " "success"

    exit 0;
}

##
# Remove legacy `dockgento` installation
#
# @return void
##
_remove_legacy_cli() {
    if [ -d "$LEGACY_CLI_DIR" ]; then
        print_message "Start legacy CLI dir removal: $LEGACY_CLI_DIR" "notice"
        rm -rf "$LEGACY_CLI_DIR"
        print_message "End legacy CLI dir removal: $LEGACY_CLI_DIR" "notice"
    fi
}

##
# Configure `dockgento`
#
# @return void
##
_configure_cli() {
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
    chmod +x "$CLI_DIR/dockgento"
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
    local bin_dir
    local dir

    print_message "Start add \`dockgento\` to commands" "notice"

    ##
    # @note Look for a user binary folder that is already part of the `PATH`
    #       environment variable. In that way, it is only required to link
    #       the CLI entry point inside it, avoiding the modification of
    #       the user shell profile
    ##
    bin_dir=""
    for dir in "$HOME/.local/bin" "$HOME/bin"; do
        if _is_in_path "$dir"; then
            bin_dir="$dir"
            break
        fi
    done

    ##
    # @note If there is no user binary folder inside the `PATH` environment
    #       variable, it is used the default one, and it is persisted
    #       inside `PATH` through the user shell profile
    ##
    if [ -z "$bin_dir" ]; then
        bin_dir="$HOME/.local/bin"
        _add_bin_dir_to_path "$bin_dir"
    fi

    ##
    # @note Link CLI entry point inside the user binary folder
    ##
    mkdir -p "$bin_dir"
    ln -sf "$CLI_DIR/dockgento" "$bin_dir/dockgento"
    print_message "\`dockgento\` is available in: $bin_dir/dockgento" "notice"

    print_message "End add \`dockgento\` to commands" "notice"
}

##
# Persist user binary folder inside `PATH` environment variable
#
# @param  string $1 User binary folder
# @return void
# @note   It is appended a marker block to the user shell profile
#         (instead of rewriting it), so other definitions are not lost
# @note   It is avoided the expansion of the `PATH` and `HOME` environment
#         variables (note the single quotes), so the user shell profile
#         does not persist a resolved/frozen `PATH` value
##
_add_bin_dir_to_path() {
    local profile

    profile="$(_get_shell_profile)"

    if grep -qF "$PATH_MARKER_START" "$profile" 2>/dev/null; then
        print_message "\`$1\` is already added to \`PATH\`" "notice"
    else
        print_message "Start add \`$1\` to \`PATH\`: $profile" "notice"
        printf '\n%s\n%s\n%s\n' \
        "$PATH_MARKER_START" \
        'export PATH="$HOME/.local/bin:$PATH"' \
        "$PATH_MARKER_END" >> "$profile"
        print_message "End add \`$1\` to \`PATH\`: $profile" "notice"
    fi
}

##
# Get user shell profile
#
# @return string
# @note   It is used the shell run commands file (instead of the login shell
#         profile), because terminal emulators usually start
#         interactive non-login shells
##
_get_shell_profile() {
    if [ -n "${ZSH_VERSION:-}" ] || [ "$(basename "${SHELL:-bash}")" = "zsh" ]
    then
        printf '%s' "$HOME/.zshrc"
    else
        printf '%s' "$HOME/.bashrc"
    fi
}

##
# Check if folder is part of `PATH` environment variable
#
# @param  string $1 Folder
# @return bool
##
_is_in_path() {
    case ":$PATH:" in
        *":$1:"*)
            return 0
            ;;

        *)
            return 1
            ;;
    esac
}

##
# @note Call main
##
main "$@"
