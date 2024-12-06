##
# @description PHP CLI (v7.3) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Magento Cloud image
# @note Improve Magento Cloud image permissions of the working directory
# @note Add custom scripts to init, install, setup and deploy
#       a Magento platform
# @link https://hub.docker.com/r/magento/magento-cloud-docker-php
# @link https://github.com/magento/magento-cloud-docker/blob/develop/images/php/cli/Dockerfile
##
FROM magento/magento-cloud-docker-php:7.3-cli-1.3.6
    ##
    # @note It seems that `ARG` variables like `MAGENTO_ROOT` 
    #       are not inherited from base images, 
    #       so it is necessary to define them again
    # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/cli/Dockerfile#L16
    ##
    ARG MAGENTO_ROOT="/app"

    ##
    # @note Init environment variables required to install a Magento platform
    # @note It is used `MAGENTO_` as a prefix for these environment variables
    #       to distinguish them from other variables that are not related
    #       to Magento installation/configuration
    # @note Because this image works with Xdebug >= `3.*`, it is only possible
    #       to install Magento >= `2.3.7`
    # @link https://github.com/magento/magento2-functional-testing-framework/commit/a31dbfcb244d062005acc7ddab0860bac264cfd6
    # @link https://github.com/magento/magento2/blob/2.3.7/composer.json#L118  
    ##
    ENV MAGENTO_VERSION="2.3.7"
    ENV MAGENTO_BASE_URL="http://magento.test/"
    ENV MAGENTO_BASE_URL_SECURE="https://magento.test/"
    ENV MAGENTO_BACKEND_FRONTNAME="admin"
    ENV MAGENTO_ADMIN_FIRSTNAME="Test F"
    ENV MAGENTO_ADMIN_LASTNAME="Test L"
    ENV MAGENTO_ADMIN_EMAIL="test@test.com"
    ENV MAGENTO_ADMIN_USER="admin"
    ENV MAGENTO_ADMIN_PASSWORD="Test123456."
    ENV MAGENTO_LANGUAGE="en_US"
    ENV MAGENTO_CURRENCY="USD"
    ENV MAGENTO_TIMEZONE="America/New_York"
    ENV MAGENTO_DB_HOST="db"
    ENV MAGENTO_DB_NAME="magento"
    ENV MAGENTO_DB_USER="magento"
    ENV MAGENTO_DB_PASSWORD="magento"
    ENV MAGENTO_AMQP_HOST="rabbitmq"
    ENV MAGENTO_AMQP_PORT="5672"
    ENV MAGENTO_AMQP_USER="magento"
    ENV MAGENTO_AMQP_PASSWORD="magento"
    ENV MAGENTO_AMQP_VIRTUALHOST="/"
    ENV MAGENTO_CACHE_BACKEND="redis"
    ENV MAGENTO_CACHE_BACKEND_REDIS_SERVER="redis"
    ENV MAGENTO_CACHE_BACKEND_REDIS_DB="0"
    ENV MAGENTO_PAGE_CACHE="redis"
    ENV MAGENTO_PAGE_CACHE_REDIS_SERVER="redis"
    ENV MAGENTO_PAGE_CACHE_REDIS_DB="1"
    ENV MAGENTO_SESSION_SAVE="redis"
    ENV MAGENTO_SESSION_SAVE_REDIS_HOST="redis"
    ENV MAGENTO_SESSION_SAVE_REDIS_LOG_LEVEL="4"
    ENV MAGENTO_SESSION_SAVE_REDIS_DB="2"
    ENV MAGENTO_OPENSEARCH_HOST="opensearch"
    ENV MAGENTO_OPENSEARCH_PORT="9200"
    ENV MAGENTO_ELASTICSEARCH_HOST="elasticsearch"
    ENV MAGENTO_ELASTICSEARCH_PORT="9200"
    ENV MAGENTO_SEARCH_ENGINE=""
    ENV MAGENTO_SEARCH_ENGINE_HOST=""
    ENV MAGENTO_SEARCH_ENGINE_PORT=""
    ENV MAGENTO_VARNISH_HOST="varnish"
    ENV MAGENTO_SMTP_HOST=""
    ENV MAGENTO_SMTP_PORT=""
    ENV MAGENTO_STATIC_CONTENT_DEPLOY_MODE="quick"
    ENV MAGENTO_STATIC_CONTENT_DEPLOY_JOBS="2"
    ENV MAGENTO_COMMAND_PATH="${MAGENTO_ROOT}/bin/magento"

    ##
    # @note Add `SGID` to folder so it is possible to share `www`
    #       user group with created files
    # @link https://www.redhat.com/sysadmin/suid-sgid-sticky-bit
    ##
    RUN chmod g+s ${MAGENTO_ROOT}

    ##
    # @note Add custom scripts to install, setup and
    #       deploy a Magento platform
    # @note Add custom script to run Magento cron
    # @note Add custom utility script to configure search engine
    # @note Add custom utility script to configure Varnish cache
    # @note Add custom utility script to configure SMTP server
    # @note Add custom utility script to clean cache
    # @note Add custom utility script to reindex
    ##
    COPY bin/init /usr/local/bin/
    COPY bin/install /usr/local/bin/
    COPY bin/setup /usr/local/bin/
    COPY bin/deploy /usr/local/bin/
    COPY bin/run-cron /usr/local/bin/
    COPY bin/configure-search-engine /usr/local/bin/
    COPY bin/configure-varnish /usr/local/bin/
    COPY bin/configure-smtp /usr/local/bin/
    COPY bin/purge-cache /usr/local/bin/
    COPY bin/reindex /usr/local/bin/
    RUN chmod +x /usr/local/bin/init
    RUN chmod +x /usr/local/bin/install
    RUN chmod +x /usr/local/bin/setup
    RUN chmod +x /usr/local/bin/deploy
    RUN chmod +x /usr/local/bin/run-cron
    RUN chmod +x /usr/local/bin/configure-search-engine
    RUN chmod +x /usr/local/bin/configure-varnish
    RUN chmod +x /usr/local/bin/configure-smtp
    RUN chmod +x /usr/local/bin/purge-cache
    RUN chmod +x /usr/local/bin/reindex

    ##
    # @note Install Magento cache watcher globally to be able to use it
    #       as a development tool
    # @link https://github.com/mage2tv/magento-cache-clean
    ##
    RUN composer global require mage2tv/magento-cache-clean
