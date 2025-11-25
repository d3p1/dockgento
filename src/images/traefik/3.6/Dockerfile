##
# @description Traefik (v3.6) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Traefik image
# @note Add healthcheck
# @note A default Traefik static configuration file is not implemented because 
#       the use of environment variables is preferred, 
#       and they are mutually exclusive
# @link https://hub.docker.com/_/traefik
# @link https://doc.traefik.io/traefik/v2.0/operations/cli/#healthcheck
# @link https://doc.traefik.io/traefik/v2.0/operations/ping/
# @link https://doc.traefik.io/traefik/getting-started/configuration-overview/#the-static-configuration
##
FROM traefik:v3.6
    HEALTHCHECK --interval=5s --timeout=5s \
                CMD traefik healthcheck
    
