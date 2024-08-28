##
# @description MariaDB (v10.4) image for a Magento 2 environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @link        https://github.com/d3p1/dockgento
##

##
# @note Use official MariaDB image
# @note Add healthcheck
# @link https://hub.docker.com/_/mariadb
# @link https://mariadb.com/kb/en/using-healthcheck-sh
##
FROM mariadb:10.4
    HEALTHCHECK --interval=5s --timeout=5s \
                CMD healthcheck.sh --connect --innodb_initialized
    