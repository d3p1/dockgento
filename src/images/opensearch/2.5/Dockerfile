##
# @description OpenSearch (v2.5) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official Magento Cloud image
# @link https://hub.docker.com/r/magento/magento-cloud-docker-opensearch
# @link https://github.com/magento/magento-cloud-docker/blob/develop/images/opensearch/2.5/Dockerfile
# @link https://opensearch.org/docs/latest/install-and-configure/install-opensearch/docker/#sample-docker-composeyml
##
FROM magento/magento-cloud-docker-opensearch:2.5-1.3.7
    ##
    # @note Remove unnecessary security plugin because the OpenSearch instance 
    #       will live on the same local network as Magento
    # @link https://opensearch.org/docs/latest/install-and-configure/install-opensearch/docker/#working-with-plugins
    ##
    ENV DISABLE_SECURITY_PLUGIN=true
    
    ##
    # @note Remove unnecessary demo plugin
    ##
    ENV DISABLE_INSTALL_DEMO_CONFIG=true

    ##
    # @note Disable JVM heap memory swapping
    ##
    ENV bootstrap.memory_lock=true

    ##
    # @note Add default min and max JVM heap sizes 
    #       (but they should be set to at least 50% of system RAM)
    ##
    ENV OPENSEARCH_JAVA_OPTS="-Xms1g -Xmx1g"

    ##
    # @note By default, run as a single node
    ##
    ENV discovery.type="single-node"

    