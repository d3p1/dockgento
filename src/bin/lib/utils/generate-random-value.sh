#!/bin/bash

##
# @description An utility to generate a random value
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Generate a random value
#
# @param  string $1 Regular expression that defines valid characters
# @param  int    $2 Length of the random value
# @return void
# @link   https://stackoverflow.com/questions/44376846/creating-a-password-in-bash
##
generate_random_value() {
    tr -dc "$1" < /dev/urandom | head -c "$2"
}