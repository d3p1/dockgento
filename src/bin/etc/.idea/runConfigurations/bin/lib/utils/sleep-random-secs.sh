#!/bin/bash

##
# @description Utility command to sleep a random number of seconds
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Sleep random number of seconds
#
# @param  int  $1 Upper boundary
# @return void
##
sleep_random_secs() {
    local time
    local boundary
    boundary="$1"

    time=$(( RANDOM % boundary + 1 ))
    sleep "$time"
}