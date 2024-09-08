#!/bin/bash

##
# @description Configure host machine required for `dockgento init` and
#              the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/print-message.sh
source $BASE_DIR/lib/utils/get-resources.sh

##
# Main
#
# @return void
# @note   Configure Magento static content deploy jobs
##
main() {
    _configure_magento_static_content_deploy_jobs
}

##
# Configure Magento static content deploy jobs
#
# @return void
# @note   It is exported the respective environment variable that
#         then will be persisted in the respective env file using
#         the `envsubst` command
##
_configure_magento_static_content_deploy_jobs() {
	print_message "[NOTICE] Start creation of environment variable \`SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS\`"
    SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS=get_number_cpus
    export SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS
    print_message "[NOTICE] End creation of environment variable \`SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS\` with value: $SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS"
}

##
# @note Call main
##
main "$@"