#!/bin/bash

##
# @description Configure `dockgento init` services
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/get-resources.sh
source $BASE_DIR/lib/utils/generate-random-value.sh

##
# Main
# 
# @return void
##
main() {
	##
	# @note Export required environment variables for db service
	##
	_configure_mariadb

	##
	# @note Export required environment variables for RabbitMQ service
	##
	_configure_rabbitmq

	##
	# @note Export required environment variables for web server service
	##
	_configure_web

    ##
    # @note Export required environment variables for search engine service
    ##
    _configure_search_engine

	##
	# @note Export required environment variables for Magento platform
	##
	_configure_magento

    ##
    # @note Return with success
    ##
    return 0
}

##
# Configure MariaDB
#
# @return void
##
_configure_mariadb() {
	print_message "[NOTICE] Start init MariaDB environment variables"
	SCRIPT_MARIADB_DB_NAME="$(_generate_random_name)"
    SCRIPT_MARIADB_USER="$(_generate_random_name)"
    SCRIPT_MARIADB_PASSWORD="$(_generate_random_password)"
    SCRIPT_MYSQL_ROOT_PASSWORD="$(_generate_random_password)"
    export SCRIPT_MARIADB_DB_NAME
    export SCRIPT_MARIADB_USER
    export SCRIPT_MARIADB_PASSWORD
    export SCRIPT_MYSQL_ROOT_PASSWORD
    print_env_var "SCRIPT_MARIADB_DB_NAME"
    print_env_var "SCRIPT_MARIADB_USER"
    print_env_var "SCRIPT_MARIADB_PASSWORD"
    print_env_var "SCRIPT_MYSQL_ROOT_PASSWORD"
    print_message "[NOTICE] End init MariaDB environment variables"
}

##
# Configure RabbitMQ
#
# @return void
##
_configure_rabbitmq() {
	print_message "[NOTICE] Start init RabbitMQ environment variables"
	SCRIPT_RABBITMQ_DEFAULT_USER="$(_generate_random_name)"
    SCRIPT_RABBITMQ_DEFAULT_PASS="$(_generate_random_password)"
    export SCRIPT_RABBITMQ_DEFAULT_USER
    export SCRIPT_RABBITMQ_DEFAULT_PASS
    print_env_var "SCRIPT_RABBITMQ_DEFAULT_USER"
    print_env_var "SCRIPT_RABBITMQ_DEFAULT_PASS"
    print_message "[NOTICE] End init RabbitMQ environment variables"
}

##
# Configure web server
#
# @return void
# @link   https://www.digitalocean.com/community/tutorials/how-to-optimize-nginx-configuration
##
_configure_web() {
	print_message "[NOTICE] Start init web server (Nginx) environment variables"
	SCRIPT_NGINX_WORKER_PROCESSES="$(get_number_cpus)"
	SCRIPT_NGINX_WORKER_CONNECTIONS="$(ulimit -n)"
	export SCRIPT_NGINX_WORKER_PROCESSES
    export SCRIPT_NGINX_WORKER_CONNECTIONS
    print_env_var "SCRIPT_NGINX_WORKER_PROCESSES"
    print_env_var "SCRIPT_NGINX_WORKER_CONNECTIONS"
    print_message "[NOTICE] End init web server (Nginx) environment variables"
}

##
# Configure search engine
#
# @return void
##
_configure_search_engine() {
	print_message "[NOTICE] Start init search engine environment variables"

	##
    # @note Export environment variable required for
    #       Docker Compose `elasticsearch` and `opensearch` services
    # @note JVM heap sizes should be at least 50% of system RAM
    # @link https://stackoverflow.com/questions/2441046/how-to-get-the-total-physical-memory-in-bash-to-assign-it-to-a-variable
    # @link https://docs.oracle.com/javase/8/docs/technotes/tools/windows/java.htm
    ##
    MEM=$(get_ram_mem)
    SEARCH_ENGINE_MEM=$(( MEM / 2 ))
    export SCRIPT_SEARCH_JAVA_OPTS="-Xms${SEARCH_ENGINE_MEM}k -Xmx${SEARCH_ENGINE_MEM}k"
    print_env_var "SCRIPT_SEARCH_JAVA_OPTS"

    ##
    # @note Evaluate search engine and export environment variables
    #       required for Docker Compose `web` service (the Magento platform
    #       requires it to set the project search engine). Also,
    #       it is used to define the Docker Compose configuration files used
    #       to setup the environment
    ##
    case "$SCRIPT_SEARCH_SERVICE" in
        elasticsearch)
            SCRIPT_MAGENTO_SEARCH_ENGINE_HOST="elasticsearch"
            SCRIPT_MAGENTO_SEARCH_ENGINE_PORT="9200"
            SCRIPT_MAGENTO_SEARCH_ENGINE="elasticsearch7"
        	;;

        opensearch)
            SCRIPT_MAGENTO_SEARCH_ENGINE_HOST="opensearch"
            SCRIPT_MAGENTO_SEARCH_ENGINE_PORT="9200"
            SCRIPT_MAGENTO_SEARCH_ENGINE="opensearch"
        	;;
    esac
    export SCRIPT_MAGENTO_SEARCH_ENGINE_HOST
    export SCRIPT_MAGENTO_SEARCH_ENGINE_PORT
    export SCRIPT_MAGENTO_SEARCH_ENGINE
    print_env_var "SCRIPT_MAGENTO_SEARCH_ENGINE_HOST"
    print_env_var "SCRIPT_MAGENTO_SEARCH_ENGINE_PORT"
    print_env_var "SCRIPT_MAGENTO_SEARCH_ENGINE"

    print_message "[NOTICE] End init search engine environment variables"
}

##
# Configure Magento
#
# @return void
##
_configure_magento() {
	print_message "[NOTICE] Start init Magento environment variables"

    SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS="$(get_number_cpus)"
	export SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS
	print_env_var "SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS"

	if [ -z "$SCRIPT_MAGENTO_ADMIN_USER" ]; then
		SCRIPT_MAGENTO_ADMIN_USER="$(_generate_random_name)"
		export SCRIPT_MAGENTO_ADMIN_USER
		print_env_var "SCRIPT_MAGENTO_ADMIN_USER"
	fi

	if [ -z "$SCRIPT_MAGENTO_ADMIN_PASSWORD" ]; then
		SCRIPT_MAGENTO_ADMIN_PASSWORD="$(_generate_random_password)"
		export SCRIPT_MAGENTO_ADMIN_PASSWORD
		print_env_var "SCRIPT_MAGENTO_ADMIN_PASSWORD"
	fi

	print_message "[NOTICE] End init Magento environment variables"
}

##
# Generate random name
#
# @return void
##
_generate_random_name() {
	generate_random_value 'A-Za-z' "10"
}

##
# Generate random password
#
# @return void
##
_generate_random_password() {
	generate_random_value 'A-Za-z0-9!?%=' "10"
}

##
# @note Call main
##
main "$@"