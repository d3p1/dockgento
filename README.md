<div align=center>

# [DOCKGENTO]

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
[![Release](https://github.com/d3p1/docker-magento/actions/workflows/release.yml/badge.svg)](https://github.com/d3p1/docker-magento/actions/workflows/release.yml)

</div>

## Introduction

*DOCKER + MAGENTO = DOCKGENTO*

## Usage

### Production use

*Remember to mention how to secure docker socket.*

### Development use

*Remember to mention how to configure `/etc/hosts` or `dnsmasq`, and how to create local certificates with `mkcert`*

## Brief technical overview

## TODOs

- Describe:
-- *How to download it and use it*
-- *How to use `BASE_` host environment variables to update container environment variables*
-- *Document `SCRIPT_` environment variables used to generate env files*
-- *How PHP CLI init Magento platform script works*
-- *How PHP CLI cron Magento platform script works*
-- *How to use Dev Containers and Xdebug in development environment*
-- *How to enable `cron` and `cli` container using the `COMPOSE_PROFILE` environment variable*
-- *How Docker Compose files and profiles are used differently to extend infra*
-- *That the deploy script was only tested in `Debian 12`*
-- *Explain that the deploy scripts must be run using a user with `sudo` privileges*
-- *Advice that for now all scripts to init environment were tested and work in Linux (Debian 12)*
-- *Advice that to execute init scripts is required `bash`*
-- *Advice that the init scripts should be executed in the same folder where the `docker-compose.yml` files are located to avoid `stat /var/www/docker-magento/src/setup/bin/docker-compose.yml: no such file or directory` error
-- *Advice to execute init script using `. bin/bootstrap.sh` to be able to set environment variables in current shell (https://stackoverflow.com/questions/496702/can-a-shell-script-set-environment-variables-of-the-calling-shell)*
-- *Advice that CLI script will require `bash`*
-- *Advice it is required a user with sudo privileges to execute bootstrap script commands*

## Changelog

Detailed changes for each release are documented in [`CHANGELOG.md`](./CHANGELOG.md).

## License

This work is published under [MIT License](./LICENSE).

## Author

Always happy to receive a greeting on:

- [LinkedIn](https://www.linkedin.com/in/cristian-marcelo-de-picciotto/) 
- [Web](https://d3p1.dev/)
