##
# @description Valkey (v8.1) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Valkey image
# @note Add healthcheck using as reference the excellent implementation in
#       `markshust/docker-magento` project
# @link https://hub.docker.com/r/valkey/valkey
# @link https://github.com/markshust/docker-magento/blob/master/compose/compose.healthcheck.yaml#L32
##
FROM valkey/valkey:8.1-alpine
    HEALTHCHECK --interval=5s --timeout=5s \
                CMD valkey-cli ping || exit 1
