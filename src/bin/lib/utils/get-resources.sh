#!/bin/bash

##
# @description An utility to get host machine resources
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Get number of CPUs
#
# @return int
# @link   https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line
##
get_number_cpus() {
    nproc --all
}

##
# Get RAM memory (in KB)
#
# @return string
# @link   https://stackoverflow.com/questions/2441046/how-to-get-the-total-physical-memory-in-bash-to-assign-it-to-a-variable
##
get_ram_mem() {
    grep MemTotal /proc/meminfo | awk '{print $2}'
}