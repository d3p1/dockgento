#!/bin/bash

##
# @description Configure services required by `dockgento mage-configure`
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/envsubst-files.sh
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
# @note   Migrate old platform DB.
#         It is decided to add this step here instead of in a
#         development scope, because there are situations where
#         can be useful to migrate a DB to a production environment.
#         For instance, when it is migrated between production infrastructures,
#         or when a platform is released and it is used the development DB
#         as seed
# @note   Add `Dockerfile` required for production environments.
#         It is decided to add this step here instead of in a
#         production scope, because this is something related to the
#         platform source code and not to the production environment itself.
#         Additionally, this step is executed here
#         and not with `dockgento init`,
#         because Magento platform should be already present and
#         this is only guarantee with this `dockgento mage-configure` command
##
_configure_magento() {
    print_message "Start Magento configuration" "notice"

    ##
    # @note Configure Magento DB if DB dump exits
    ##
    _configure_magento_db

    ##
    # @note Copy `Dockerfile` to app so it is possible
    #       to build production image
    # @note Replace `${SCRIPT_*}` variables inside `Dockerfile` with
    #       current environment data.
    #       In that way, the `Dockerfile` already has useful default data
    #       for the production image generation
    ##
    cp -R "$BASE_DIR/etc/Dockerfile.prod" "$SCRIPT_DOC_ROOT_DIR/Dockerfile"
    envsubst_files "$SCRIPT_DOC_ROOT_DIR/Dockerfile" '${SCRIPT_PHP_VERSION}'

    print_message "End Magento configuration" "notice"
}

##
# Configure Magento DB
#
# @returns void
##
_configure_magento_db() {
    ##
    # @note Check if DB dump location is given to init DB migration
    ##
    if [ -z "$SCRIPT_DB_DUMP" ]; then
        return 0
    fi

    print_message "Start Magento DB configuration" "notice"

    ##
    # @note In order to configure a Magento DB platform,
    #       MariaDB and other resources should be running,
    #       to avoid Magento exceptions
    ##
    docker compose up -d

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
    # @todo For now, to make sure that the `mariadb` service
    #       and its server is running
    #       the script sleeps for 5 seconds. Improve this logic
    # @link https://superuser.com/questions/1628497/docker-exec-with-dollar-variable
    ##
    print_message "Start DB deploy" "notice"
    sleep 5s
    docker compose cp "$SCRIPT_DB_DUMP" mariadb:/tmp/db.sql
    docker compose exec mariadb sh -c \
    'mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /tmp/db.sql'
    print_message "End DB deploy" "notice"

    ##
    # @note The `cli` service uses the project PHP CLI image.
    #       This image has an `init` script that receives as first param
    #       a flag to determine if it is required to execute an installation.
    #       If it is set to `true` (`1`),
    #       then a Magento platform installation is
    #       executed. If it is set to `false` (`0`), then a Magento set up
    #       action is executed.
    #       In this case, it is executed a Magento set up so the new
    #       DB is configured to use our environment services
    # @note It is used `docker compose run cli`
    #       instead of `docker compose up cli`
    #       to be able to define command to run (it is not possible to do that
    #       using `docker compose up <service>`)
    # @link https://hub.docker.com/r/d3p1/magento-php
    ##
    docker compose run --rm cli init 0

    print_message "End Magento DB configuration" "notice"
}

##
# @note Call main
##
main "$@"