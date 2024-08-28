##
# @description RabbitMQ (v3.12) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official RabbitMQ image
# @note Add healthcheck
# @link https://hub.docker.com/_/rabbitmq
# @link https://devops.stackexchange.com/questions/12092/docker-compose-healthcheck-for-rabbitmq
##
FROM rabbitmq:3.12
    HEALTHCHECK --interval=30s --timeout=30s \
                CMD rabbitmq-diagnostics -q ping
    