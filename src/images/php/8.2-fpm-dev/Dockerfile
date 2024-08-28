##
# @description PHP-FPM (v8.2) image (with development purpose) 
#              for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @note        The main porpouse of this image is to implement 
#              a PHP-FPM container for development porpouse.
#              The official PHP-FPM image already includes PHP CLI, 
#              but Composer has been added as a primary tool for managing
#              code dependencies. Also, Xdebug has been installed 
#              for debugging purpose (the web server can be configured to 
#              redirect requests to the container with this image, 
#              allowing for analysis with Xdebug).
#              In this way, it is possible to connect to the container with
#              this image and work with an already implemented development
#              environment (i.e.: using Dev Container)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use respective PHP-FPM image as base image
# @note Add Composer so this image could be used for development purpose
# @note Add Xdebug for debugging purpose
##
FROM d3p1/magento-php:8.2-fpm
     ##
     # @note Add Composer
     # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/cli/Dockerfile#L21
     # @link https://stackoverflow.com/questions/27093612/in-a-dockerfile-how-to-update-path-environment-variable
     ##
     ENV COMPOSER_MEMORY_LIMIT=-1
     ENV COMPOSER_ALLOW_SUPERUSER=1
     ENV COMPOSER_HOME="/composer"
     ENV PATH="${PATH}:${COMPOSER_HOME}/vendor/bin"
     COPY --from=d3p1/magento-php:8.2-cli \
          /usr/local/bin/composer \
          /usr/local/bin/composer
     RUN mkdir ${COMPOSER_HOME}
     RUN chown -R www:www ${COMPOSER_HOME}

     ##
     # @note Install Magento cache watcher globally to be able to use it
     #       as a development tool
     # @link https://github.com/mage2tv/magento-cache-clean
     ##
     RUN composer global require mage2tv/magento-cache-clean

     ##
     # @note Add Xdebug as current enabled extensions
     # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/fpm/docker-entrypoint.sh#L13
     ##
     ENV PHP_EXTENSIONS="bcmath bz2 calendar exif gd gettext intl mysqli opcache pdo_mysql redis soap sockets sodium sysvmsg sysvsem sysvshm xsl zip pcntl xdebug"

     ##
     # @note Add custom entrypoint to include startup logic
     # @link https://github.com/magento/magento-cloud-docker/blob/9998e5615a37cc584ac26b236104ae040aa6e0c5/images/php/fpm/Dockerfile#L72
     ##
     COPY main.docker-entrypoint.sh /
     RUN chmod +x /main.docker-entrypoint.sh
     ENTRYPOINT ["/main.docker-entrypoint.sh"]
     CMD ["php-fpm", "-R"]