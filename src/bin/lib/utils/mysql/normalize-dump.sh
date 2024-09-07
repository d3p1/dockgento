#!/bin/bash

##
# @description Utilities to normalize MySQL DB dump
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Normalize DB dump
#
# @param  string $1 DB dump path
# @return void
# @link   https://github.com/markshust/docker-magento?tab=readme-ov-file#database
##
normalize_db_dump() {
    sed 's/\sDEFINER=`[^`]*`@`[^`]*`//g' -i "$1"
}