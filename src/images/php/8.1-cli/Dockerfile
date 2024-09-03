##
# @description PHP CLI (v8.1) image for a Magento 2 environment
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
FROM magento/magento-cloud-docker-php:8.1-cli-1.3.7
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
    ##
    ENV MAGENTO_VERSION="2.4.6"
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
    ENV MAGENTO_VARNISH_HOST="varnish"
    ENV MAGENTO_SMTP_HOST="mailhog"
    ENV MAGENTO_SMTP_PORT="1025"
    ENV MAGENTO_STATIC_CONTENT_DEPLOY_MODE="quick"
    ENV MAGENTO_STATIC_CONTENT_DEPLOY_JOBS="2"
    ENV MAGENTO_COMMAND_PATH="${MAGENTO_ROOT}/bin/magento"

    ##
    # @note Add `SGID` to folder so it is possible to share `www` group
    #       with created files
    # @link https://www.redhat.com/sysadmin/suid-sgid-sticky-bit
    ##
    RUN chmod g+s ${MAGENTO_ROOT}

    ##
    # @note Add custom scripts to install, setup and
    #       deploy a Magento platform
    # @note Add custom script to run Magento cron
    # @note Add custom utility script to configure Varnish cache
    # @note Add custom utility script to configure SMTP server
    ##
    COPY bin/init /usr/local/bin/
    COPY bin/install /usr/local/bin/
    COPY bin/setup /usr/local/bin/
    COPY bin/deploy /usr/local/bin/
    COPY bin/run-cron /usr/local/bin/
    COPY bin/lib/configure-varnish /usr/local/bin/lib/
    COPY bin/lib/configure-smtp /usr/local/bin/lib/
    RUN chmod +x /usr/local/bin/init
    RUN chmod +x /usr/local/bin/install
    RUN chmod +x /usr/local/bin/setup
    RUN chmod +x /usr/local/bin/deploy
    RUN chmod +x /usr/local/bin/run-cron
    RUN chmod +x /usr/local/bin/lib/configure-varnish
    RUN chmod +x /usr/local/bin/lib/configure-smtp
