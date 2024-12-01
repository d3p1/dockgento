##
# @description Nginx (v1.24) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Magento Cloud image
# @note Add healthcheck using as reference the excellent implementation in
#       `markshust/docker-magento` project
# @note Improve `XDEBUG_HOST` service name
# @note Create `www` user and group (`1000:1000`) 
#       so it is possible to match host user with this container user
# @link https://hub.docker.com/r/magento/magento-cloud-docker-nginx
# @link https://github.com/magento/magento-cloud-docker/blob/develop/images/nginx/1.24/Dockerfile
# @link https://github.com/markshust/docker-magento/blob/master/compose/compose.healthcheck.yaml#L5
##
FROM magento/magento-cloud-docker-nginx:1.24-1.3.6
    ##
    # @note Improve `XDEBUG_HOST` service name 
    ##
    ENV XDEBUG_HOST="fpm"
    
    ##
    # @note Create `www` user and group (`1000:1000`)
    # @note Update working directory ownership to `www:www` so it can
    #       be accessed by the host user (`1000:1000`)
    # @note Add `SGID` to folder so it is possible to share `www` group
    #       with created files
    # @link https://www.redhat.com/sysadmin/suid-sgid-sticky-bit
    ##
    RUN groupadd -g 1000 www && \
        useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www
    RUN chown -R www:www ${MAGENTO_ROOT}
    RUN chmod g+s ${MAGENTO_ROOT}

    ##
    # @note It is used a 5 minutes delay in the healthcheck (`--start-period`) 
    #       just in case it is necessary to wait for some 
    #       Magento install/upgrade/initialization bootstrap logic
    ##
    HEALTHCHECK --interval=5s --timeout=5s --start-period=3000s \
                CMD curl --fail 127.0.0.1:"$UPSTREAM_PORT"