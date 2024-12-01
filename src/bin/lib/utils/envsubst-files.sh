#!/bin/bash

##
# @description An utility to `envsubst` files in current directory
#              and subdirectories
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Look for files inside current directory and subdirectories that match pattern,
# and replace them with `envsubst` result
#
# @param  string $1 Pattern
# @param  string $2 Variables to replace
# @return void
# @link   https://stackoverflow.com/questions/9612090/how-to-loop-through-file-names-returned-by-find
# @link   https://unix.stackexchange.com/questions/181937/how-create-a-temporary-file-in-shell-script
##
envsubst_files() {
    shopt -s globstar
    for file in **/$1; do
        envsubst_file "$file" "$2"
    done
}

##
# Replace file with `envsubst` result
#
# @param  string $1 File
# @param  string $2 Variables to replace
# @return void
##
envsubst_file() {
    local tmp
    tmp=$(mktemp)
    envsubst "$2" < "$1" > "$tmp" && mv "$tmp" "$1"
}