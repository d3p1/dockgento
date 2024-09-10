#!/bin/bash

##
# @description Dockgento command to setup a Magento platform
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
	_setup_magento_platform
}

##
# Setup Magento platform
#
# @return void
# @note   It is used `docker compose run cli` instead of `docker compose up cli`
#         to be able to define command to run (it is not possible to do that
#         using `docker compose up <service>`)
##
_setup_magento_platform() {
	##
	# @note In order to setup a Magento platform,
    #       the Redis, MariaDB and other resources should be running,
    #       to avoid Magento exceptions
	# @note The `cli` service uses the project PHP CLI image.
	#       This image has an `init` script that receives as first param
	#       a flag to determine if it is required to execute an installation.
	#       If it is set to `true`, then a Magento platform installation is
	#       executed. If it is set to `false`, then a Magento setup is executed
	# @link https://hub.docker.com/r/d3p1/magento-php
	##
	print_message "[NOTICE] Start Magento setup"
	docker compose up -d
	_migrate_db "$SCRIPT_DB_DUMP"
	docker compose run --rm cli init 0
	print_message "[NOTICE] End Magento setup"
}

##
# Migrate DB
#
# @param  string $1 DB dump path
# @return void
##
_migrate_db() {
	print_message "[NOTICE] Start DB migration"

    ##
    # @note The DB dump is normalized to avoid user permission errors
    # @link https://github.com/markshust/docker-magento?tab=readme-ov-file#database
    ##
    print_message "[NOTICE] Start DB normalization"
    normalize_db_dump "$1"
    print_message "[NOTICE] End DB normalization"

    ##
    # @note The DB dump is copied to the DB service to be able to migrate it
    #       using service commands
    # @note It is executed the DB dump migration command within a new
    #       container shell to be able to use container environment variables
    # @link https://superuser.com/questions/1628497/docker-exec-with-dollar-variable
    ##
    print_message "[NOTICE] Start DB deploy"
    docker compose cp "$1" mariadb:/tmp/db.sql
    docker compose exec mariadb sh -c \
    'mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /tmp/db.sql'
    print_message "[NOTICE] End DB deploy"

    print_message "[NOTICE] End DB migration"
}

##
# @note Call main
##
main "$@"