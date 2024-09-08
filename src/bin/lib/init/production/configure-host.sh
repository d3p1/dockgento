#!/bin/bash

##
# @description Configure production host machine required for `dockgento init`
#              and the Magento environment that it generates
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# @note Import required utilities
##
source $BASE_DIR/lib/utils/log.sh
source $BASE_DIR/lib/utils/docker/configure.sh

##
# Main
# 
# @return void
##
main() {
    ##
    # @note Configure `docker` in rootless mode to mitigate potential
    #       vulnerabilities
    ##
    _configure_docker_rootless_mode

    ##
    # @note Configure host to work properly with search engine
    #       (OpenSearch or Elasticsearch)
    ##
    _configure_search_engine

    ##
    # @note Configure Traefik service
    ##
    _configure_traefik
}

##
# Configure `docker` in rootless mode
#
# @return void
##
_configure_docker_rootless_mode() {
    print_message "[NOTICE] Start configuration of \`docker\` in rootless mode"
    configure_docker_rootless_mode
    print_message "[NOTICE] End configuration of \`docker\` in rootless mode"
}

##
# Implement required search engine configuration
#
# @return void
# @note   Both (Elasticsearch and OpenSearch) mentioned a similar configuration
#         (that makes sense because OpenSearch is a fork of Elasticsearch)
# @link   https://www.elastic.co/guide/en/elasticsearch/reference/7.5/docker.html#_set_vm_max_map_count_to_at_least_262144
# @link   https://opensearch.org/docs/latest/install-and-configure/install-opensearch/index/#important-settings
# @link   https://opensearch.org/docs/latest/install-and-configure/install-opensearch/docker/#configure-important-host-settings
##
_configure_search_engine() {
    ##
    # @note Set required `vm.max_map_count`
    # @note It is considered that the appended `vm.max_map_count`
    #       will overwrite older ones
    # @note Disable memory paging and swapping
    # @link https://stackoverflow.com/questions/4749330/how-to-test-if-string-exists-in-file-with-bash
    ##
    print_message "[NOTICE] Start configuration of search engine"
    if ! grep -Fxq "vm.max_map_count=262144" /etc/sysctl.conf; then
        echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
    fi
    sudo sysctl -p
    sudo swapoff -a
    print_message "[NOTICE] End configuration of search engine"
}

##
# Configure Traefik
# 
# @return void
##
_configure_traefik() {
    local traefik_acme_file_path

    ##
    # @note Create file to store SSL certificates
    # @note Set correct permissions to file to avoid error:
    #       `traefik-1  | time="2024-03-26T03:03:26Z" \
    #        level=error msg="The ACME resolver \"le-http\" is skipped from \
    #        the resolvers list because: unable to get ACME account: \
    #        permissions 644 for /etc/traefik/acme.json are too open, \
    #        please use 600"`
    ##
    traefik_acme_file_path="$BASE_DIR/etc/services/traefik/etc/acme.json"
    if [ ! -e traefik_acme_file_path ]; then
		print_message "[NOTICE] Start configuration of Traefik"
		touch "$traefik_acme_file_path"
		chmod 600 "$traefik_acme_file_path"
		print_message "[NOTICE] End configuration of Traefik"
    fi
}

##
# @note Call main
##
main "$@"
