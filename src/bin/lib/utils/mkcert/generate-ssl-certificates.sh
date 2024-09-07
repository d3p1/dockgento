#!/bin/bash

##
# @description An utility to generate SSL certificates with `mkcert`
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
##

##
# Generate SSL certificates
#
# @param  string $1 Certificate names
# @param  string $2 Certificate domain
# @param  string $3 Path where SSL certificates should be located
# @return void
# @link   https://github.com/FiloSottile/mkcert
##
generate_ssl_certifcates() {    
    local key
    local crt
    
    key="$1".key
    crt="$1".crt
    mkcert \
    -key-file "$key" \
    -cert-file "$crt" \
    "$2" "*.$2"
    
    mv "$key" "$3"
    mv "$crt" "$3"
}