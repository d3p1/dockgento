#!/bin/bash

##
# @description Configure services required by `dockgento mage-configure`
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/mysql/normalize-dump.sh

##
# Main
#
# @return void
##
main() {
    _configure_magento
}

##
# Configure Magento
#
# @return void
# @note   Migrate old platform DB
##
_configure_magento() {
    print_message "Start Magento configuration" "notice"

    ##
    # @note The DB dump is normalized to avoid user permission errors
    # @link https://github.com/markshust/docker-magento?tab=readme-ov-file#database
    ##
    print_message "Start DB normalization" "notice"
    normalize_db_dump "$SCRIPT_DB_DUMP"
    print_message "End DB normalization" "notice"

    ##
    # @note The DB dump is copied to the DB service to be able to migrate it
    #       using service commands
    # @note It is executed the DB dump migration command within a new
    #       container shell to be able to use container environment variables
    # @todo For now, to make sure that the `mariadb` service and its server is running
    #       the script sleeps for 5 seconds. Improve this logic
    # @link https://superuser.com/questions/1628497/docker-exec-with-dollar-variable
    ##
    print_message "Start DB deploy" "notice"
    sleep 5s
    docker compose cp "$SCRIPT_DB_DUMP" mariadb:/tmp/db.sql
    docker compose exec mariadb sh -c \
    'mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /tmp/db.sql'
    print_message "End DB deploy" "notice"

    print_message "End Magento configuration" "notice"
}

##
# @note Call main
##
main "$@"