##
# @description Varnish (v6.6) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Magento Cloud image
# @note Add healthcheck
# @link https://hub.docker.com/r/magento/magento-cloud-docker-varnish
# @link https://github.com/magento/magento-cloud-docker/blob/develop/images/varnish/6.6/Dockerfile
# @link https://hub.docker.com/_/varnish
##
FROM magento/magento-cloud-docker-varnish:6.6-1.4.0
    ##
    # @note Install cURL needed for healtcheck command
    ##
    RUN set -e; \
        apt-get update; \
        apt-get -y install curl

    ##
    # @note Set default value to Varnish HTTP port environment variable
    ##
    ENV VARNISH_HTTP_PORT="80"
    
    ##
    # @note Add healthcheck command
    # @note It is used a 5 minutes delay in the healthcheck (`--start-period`) 
    #       just in case it is necessary to wait for some 
    #       Magento install/upgrade/initialization bootstrap logic
    # @note This `--start-period` is the same as the one used in the 
    #       `d3p1/magento-nginx` image. However, there is no cleaner or 
    #       easier way to share this value (as it is not possible to use 
    #       environment variables inside the `HEALTHCHECK` command). 
    #       Nevertheless, it is not considered a relevant feature 
    #       to share this configuration
    # @link https://hub.docker.com/r/d3p1/magento-nginx
    ##
    HEALTHCHECK --interval=5s --timeout=5s --start-period=3000s \
                CMD curl --fail 127.0.0.1:"$VARNISH_HTTP_PORT"
    