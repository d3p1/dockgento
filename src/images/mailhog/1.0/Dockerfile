##
# @description MailHog (v1.0) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Magento Cloud image
# @note Add healthcheck
# @link https://hub.docker.com/r/magento/magento-cloud-docker-mailhog
# @link https://github.com/magento/magento-cloud-docker/blob/develop/images/mailhog/1.0/Dockerfile
##
FROM magento/magento-cloud-docker-mailhog:1.0-1.3.7
    ##
    # @note Switch to `root` user 
    #       to be able to install cURL needed for healtcheck command
    ##
    USER root
    RUN apk --no-cache add curl

    ##
    # @note Switch to `mailhog` user
    ##
    USER mailhog
    
    ##
    # @note Add healthcheck command
    ##
    HEALTHCHECK --interval=5s --timeout=5s \
                CMD curl --fail 127.0.0.1:8025
    