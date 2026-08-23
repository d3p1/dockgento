##
# @description PHP FPM (v8.4) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Magento Cloud image
# @note Improve Magento Cloud image permissions of the working directory
# @note Add healthcheck
# @note Improve Xdebug usage
# @link https://hub.docker.com/r/magento/magento-cloud-docker-php
# @link https://github.com/magento/magento-cloud-docker/blob/develop/images/php/fpm/Dockerfile
# @link https://github.com/renatomefi/php-fpm-healthcheck
##
FROM magento/magento-cloud-docker-php:8.4-fpm-1.4.9
    ##
    # @note Install APCu
    # @link https://experienceleague.adobe.com/en/docs/commerce-operations/performance-best-practices/software
    ##
    RUN pecl install apcu

    ##
    # @note Add APCu to enabled extensions
    # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/cli/docker-entrypoint.sh#L17
    # @link https://github.com/magento/magento-cloud-docker/blob/688c61cf41503c197530bfaea7f84a7ea133cd91/images/php/8.1-cli/Dockerfile#L32
    # @link https://experienceleague.adobe.com/en/docs/commerce-operations/performance-best-practices/software
    ##
    ENV PHP_EXTENSIONS="bcmath bz2 calendar exif gd gettext intl mysqli opcache pdo_mysql redis soap sockets sodium sysvmsg sysvsem sysvshm xsl zip pcntl ftp apcu"

    ##
    # @note It seems that `ARG` variables like `MAGENTO_ROOT` 
    #       are not inherited from base images, 
    #       so it is necessary to define them again
    # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/fpm/Dockerfile#L15
    ##
    ARG MAGENTO_ROOT="/app"

    ##
    # @note Add `SGID` to folder so it is possible to share `www` group
    #       with created files
    # @link https://www.redhat.com/sysadmin/suid-sgid-sticky-bit
    ##
    RUN chmod g+s ${MAGENTO_ROOT}

    ##
    # @note Add read permission to the base image entry point.
    #       It is added to the base image with restrictive permissions
    #       (`-rwx--x--x`) and it is owned by `root`, so a non-root user
    #       (like `www`) is not able to read it. Consequently, the shell
    #       is not able to interpret it (`Permission denied`), and
    #       the container cannot be executed with a non-root user
    # @link https://github.com/magento/magento-cloud-docker/blob/1.4.9/images/php/fpm/Dockerfile#L58
    ##
    RUN chmod a+r /docker-entrypoint.sh

    ##
    # @note Add custom Xdebug configuration to connect it to our local IDE
    # @link https://github.com/magento/magento-cloud-docker/blob/36d595ca424dd73d104459f89a8c0d42617f601d/images/php/7.4-fpm/Dockerfile#L160
    ##
    COPY etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini

    ##
    # @note It is installed the script that performs the healthckeck
    #       with its required dependency (`fcgi`)
    # @link https://github.com/renatomefi/php-fpm-healthcheck/tree/v0.5.0
    #
    ##
    COPY bin/php-fpm-healthcheck.sh /usr/local/bin/
    RUN chmod +x /usr/local/bin/php-fpm-healthcheck.sh
    RUN set -x && \
        apt-get update && \
        apt-get install -y libfcgi-bin
    
    ##
    # @note It is required to enable the PHP FPM status page
    #       to be able to execute the healthcheck script
    # @link https://github.com/renatomefi/php-fpm-healthcheck/blob/v0.5.0/test/Dockerfile-buster
    ##
    RUN set -xe && echo "pm.status_path = /status" \
        >> /usr/local/etc/php-fpm.d/zz-docker.conf
    
    ##
    # @note Add healthcheck
    # @link https://github.com/renatomefi/php-fpm-healthcheck?tab=readme-ov-file#docker-example
    ##
    HEALTHCHECK --interval=5s --timeout=1s CMD php-fpm-healthcheck.sh || exit 1
    