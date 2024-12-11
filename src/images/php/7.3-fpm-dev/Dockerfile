##
# @description PHP FPM (v7.3) image (with development purpose)
#              for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @note        The main porpouse of this image is to implement 
#              a PHP FPM container for development porpouse.
#              The official PHP FPM image already includes PHP CLI,
#              but Composer has been added as a primary tool for managing
#              code dependencies. Also, Xdebug has been installed 
#              for debugging purpose (the web server can be configured to 
#              redirect requests to the container with this image, 
#              allowing for analysis with Xdebug).
#              In addition to that, other common developer tools were added.
#              In this way, it is possible to connect to the container with
#              this image and work with an already implemented development
#              environment (i.e.: using Dev Container)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use respective PHP FPM image as base image
# @note Add Composer so this image could be used for development purpose
# @note Add common developer tools
# @note Add Xdebug for debugging purpose
##
FROM d3p1/magento-php:7.3-fpm
    ##
    # @note Add Composer
    # @note Add Composer binary folder to `$PATH` so it is possible to execute
    #       global utilities without having to locate them by path
    # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/cli/Dockerfile#L21
    # @link https://stackoverflow.com/questions/27093612/in-a-dockerfile-how-to-update-path-environment-variable
    ##
    ENV COMPOSER_MEMORY_LIMIT=-1
    ENV COMPOSER_ALLOW_SUPERUSER=1
    ENV COMPOSER_HOME="/composer"
    ENV PATH="${PATH}:${COMPOSER_HOME}/vendor/bin"
    COPY --from=d3p1/magento-php:7.3-cli \
         /usr/local/bin/composer \
         /usr/local/bin/composer
    RUN mkdir ${COMPOSER_HOME}
    RUN chown -R www:www ${COMPOSER_HOME}

    ##
    # @note Install common/required development tools
    ##
    RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y --no-install-recommends \
           git \
           mariadb-client \
           nodejs \
           python3 \
           python3-pip \
           redis-tools && \
        rm -rf /var/lib/apt/lists/*

    ##
    # @note Install Magento cache watcher globally to be able to use it
    #       as a development tool
    # @note Switch temporarily to `www` user to avoid change
    #       ownership of Composer files to `root`
    # @link https://github.com/mage2tv/magento-cache-clean
    ##
    USER www
    RUN composer global require mage2tv/magento-cache-clean
    USER root

    ##
    # @note Remove Xdebug configuration customization done in base image,
    #       so Xdebug can connect to an IDE that lives in the container.
    #       This is useful because the main porpouse of this image is
    #       to be able to use it to run a Dev Container
    # @link https://github.com/magento/magento-cloud-docker/blob/36d595ca424dd73d104459f89a8c0d42617f601d/images/php/7.4-fpm/Dockerfile#L160
    ##
    COPY etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini

    ##
    # @note Add Xdebug as current enabled extensions
    # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/fpm/docker-entrypoint.sh#L13
    ##
    ENV PHP_EXTENSIONS="bcmath bz2 calendar exif gd gettext intl mysqli pdo_mysql redis soap sockets sodium sysvmsg sysvsem sysvshm xsl zip pcntl xdebug"

    ##
    # @note Add custom entrypoint to include startup logic
    # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/fpm/Dockerfile#L72
    ##
    COPY main.docker-entrypoint.sh /
    RUN chmod +x /main.docker-entrypoint.sh
    ENTRYPOINT ["/main.docker-entrypoint.sh"]
    CMD ["php-fpm", "-R"]