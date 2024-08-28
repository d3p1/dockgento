##
# @description Elasticsearch (v7.11) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Magento Cloud image
# @link https://hub.docker.com/r/magento/magento-cloud-docker-elasticsearch
# @link https://github.com/magento/magento-cloud-docker/blob/develop/images/elasticsearch/7.11/Dockerfile
##
FROM magento/magento-cloud-docker-elasticsearch:7.11-1.3.7
    ##
    # @note Disable JVM heap memory swapping
    ##
    ENV bootstrap.memory_lock=true

    ##
    # @note Add default min and max JVM heap sizes 
    #       (but they should be set to at least 50% of system RAM)
    ##
    ENV ES_JAVA_OPTS="-Xms1g -Xmx1g"