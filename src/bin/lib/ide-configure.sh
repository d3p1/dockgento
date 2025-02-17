#!/bin/bash

##
# @description Dockgento command to configure an IDE to work with
#              this Magento environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @note        It was considered whether the logic of this command could be
#              integrated into one of the existing commands (e.g.,
#              `dockgento init`, `dockgento mage-install`, or
#              `dockgento mage-configure`), but the best approach was to make it
#              an independent command.
#              Setting up the IDE is necessary for both
#              new Magento installations (`dockgento mage-install`)
#              as well as for
#              already existing installations (`dockgento mage-configure`),
#              but the platform's source code must already be present to apply
#              the required IDE configurations.
#              Additionally, it's understood that this command will primarily
#              be needed for development environments,
#              but no validation is performed for this (e.g.,
#              checking the value of the `SCRIPT_MODE` variable)
#              to provide greater flexibility and allow it to be run
#              whenever deemed necessary
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh

##
# @note Declare required constants
##
declare JETBRAINS_IDE_KEY="phpstorm"
declare VSCODE_IDE_KEY="vscode"

##
# Main
#
# @return void
##
main() {
    _generate_ide_files
}

##
# Generate IDE files in source code directory
#
# @return void
# @todo   Currently, it will only copy startup scripts
#         for JetBrains IDE. It should be added more configuration
#         files and other IDEs, too
##
_generate_ide_files() {
    print_message "Start copy IDE files" "notice"
    case "$SCRIPT_IDE_KEY" in
        "$JETBRAINS_IDE_KEY")
            if [ -n "$SCRIPT_DOC_ROOT_DIR" ]; then
                print_message "Start copy JetBrains files" "notice"
                cp -R "$BASE_DIR/etc/.idea" "$SCRIPT_DOC_ROOT_DIR/.idea"
                print_message "End copy JetBrains files" "notice"
            fi
            ;;

        "$VSCODE_IDE_KEY")
            ;;
    esac
    print_message "End copy IDE files" "notice"
}

##
# @note Call main
##
main "$@"