<div align=center>

# [DOCKGENTO]

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
[![Release](https://github.com/d3p1/dockgento/actions/workflows/release.yml/badge.svg)](https://github.com/d3p1/dockgento/actions/workflows/release.yml)

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
-- *Difference between `BASE_`, `SCRIPT_` and `MAGENTO_` environment variables* 
-- *How PHP CLI init Magento platform script works*
-- *How PHP CLI cron Magento platform script works*
-- *How to use Dev Containers and Xdebug in development environment*
-- *How to enable `cron` and `cli` container using the `COMPOSE_PROFILE` environment variable*
-- *How Docker Compose files and profiles are used differently to extend infra*
-- *That the deploy script was only tested in `Debian 12`*
-- *Explain that the deploy scripts must be run using a user with `sudo` privileges*
-- *Advice that for now all scripts to init environment were tested and work in Linux (Debian 12)*
-- *Advice that to execute init scripts is required `bash`*
-- *Advice that the init scripts should be executed in the same folder where the `docker-compose.yml` files are located to avoid `stat /var/www/dockgento/src/setup/bin/docker-compose.yml: no such file or directory` error
-- *Advice to execute init script using `. bin/bootstrap.sh` to be able to set environment variables in current shell (https://stackoverflow.com/questions/496702/can-a-shell-script-set-environment-variables-of-the-calling-shell)*
-- *Advice that CLI script will require `bash`*
-- *Advice it is required a user with sudo privileges to execute bootstrap script commands*
-- *Document how `PHP` `CLI`, `FPM` and `FPM-DEV` images/services, differ. Document that the `CLI` image has all the scripts to install, manage and deploy the platform. The `FPM` is the responsible of attending `PHP` request, but the `FPM-DEV` image is particularly useful to work with `Dev Containers`, because when `Xdebug` cookie session is set, the `Nginx` will redirect requests to them (that is why it has `Composer`, `Node`, `Redis CLI` and `MariaDB CLI` installed), so it is possible to just connect to that container to debug and implement features inside it* 
-- *Document how request flow works. `Traefik` works as an SSL termination that redirects requests to `Varnish`, and `Varnish` configures `web` services name as its backend origin server (check `vcl` config file), so `Nginx` service should have that name so it receives the request and redirect them to `FPM` service or `FPM-DEV` service (depending if `Xdebug` cookie is set)*
-- *Document that is not required to add `extra_hosts` configuration to Docker Compose files to be able to map `host.docker.internal` hostname to host (to be able to use `Xdebug`), because image entrypoints already add respective host inside `/etc/hosts` file*
-- *Document how environment files are structured. Explain that service env files inherits common environment variables from `.env` file. The `.env` file is the entrypoint and main point to define common environment variables and general environment variables.*
-- *Explain the idea of `dockgento` and `KISS`. The idea is to just setup the necessary `Docker Compose` environment and then any additional steps using `Docker Compose` commands and `services` scripts (like start the environment, installing a `Magento` platform, etc.) *
-- *Explain the it is possible to use just `docker compose up -d` because it is used the environment variable `COMPOSE_FILE` inside the `.env` to the define the respective `Docker Compose` files to use taking into consideration the environment defined*
-- *Mention how to work with credentials that are persisted inside the environment files in a production environment*
-- *Explain how the `dockgento` script works (the use of the environment variables, `envsubst` command, `.dockgento_profile` file, etc.)* 
-- *Remember to mention to init the `cron` service if it is necessary with `docker compose start cron`*
-- *Document how to use the different scripts of the `cli` service (like the one that allows the installation of a Magento platform or the setup of a Magento platform)*  
-- *Analyze if there is a way to encapsulate the repetitive code that is done inside install dependencies logic (that installs a given tool like `docker` or `mkcert`)*
-- *Explain the `.dockgento_profile` file (based in `.bash_profile`) and what each environment variable does (and when it is used - when it is required for certain environment):*
--- BASE_DOCKER_PATH="${SCRIPT_DOCKER_PATH}"
--- BASE_USER_EMAIL="${SCRIPT_USER_EMAIL}"
--- BASE_DOMAIN="${SCRIPT_DOMAIN}"
--- BASE_MARIADB_DB_NAME="${SCRIPT_MARIADB_DB_NAME}"
--- BASE_MARIADB_DB_USER="${SCRIPT_MARIADB_USER}"
--- BASE_MARIADB_DB_PASSWORD="${SCRIPT_MARIADB_PASSWORD}"
--- BASE_MARIADB_VERSION="${SCRIPT_MARIADB_VERSION}"
--- BASE_RABBITMQ_DEFAULT_USER="${SCRIPT_RABBITMQ_DEFAULT_USER}"
--- BASE_RABBITMQ_DEFAULT_PASS="${SCRIPT_RABBITMQ_DEFAULT_PASS}"
--- BASE_SMTP_HOST="${SCRIPT_SMTP_HOST}"
--- BASE_SMTP_PORT="${SCRIPT_SMTP_PORT}"
--- BASE_DEV_DOC_ROOT_DIR="${SCRIPT_DEV_DOC_ROOT_DIR}"
--- BASE_PHP_VERSION="${SCRIPT_PHP_VERSION}"
--- BASE_SEARCH_SERVICE="${SCRIPT_SEARCH_SERVICE}"
--- BASE_SEARCH_JAVA_OPTS="${SCRIPT_SEARCH_JAVA_OPTS}"
--- COMPOSE_FILE="${SCRIPT_COMPOSE_FILE}"
--- MAGENTO_COMPOSER_USERNAME="${SCRIPT_MAGENTO_COMPOSER_USERNAME}"
--- MAGENTO_COMPOSER_PASSWORD="${SCRIPT_MAGENTO_COMPOSER_PASSWORD}"
--- MAGENTO_VERSION="${SCRIPT_MAGENTO_VERSION}"
--- MAGENTO_RUN_MODE="${SCRIPT_MAGENTO_RUN_MODE}"
--- MAGENTO_STATIC_CONTENT_DEPLOY_JOBS="${SCRIPT_MAGENTO_STATIC_CONTENT_DEPLOY_JOBS}"
--- MAGENTO_ADMIN_FIRSTNAME="${SCRIPT_MAGENTO_ADMIN_FIRSTNAME}"
--- MAGENTO_ADMIN_LASTNAME="${SCRIPT_MAGENTO_ADMIN_LASTNAME}"
--- MAGENTO_ADMIN_USER="${SCRIPT_MAGENTO_ADMIN_USER}"
--- MAGENTO_ADMIN_PASSWORD="${SCRIPT_MAGENTO_ADMIN_PASSWORD}"
--- MAGENTO_SEARCH_ENGINE="${SCRIPT_MAGENTO_SEARCH_ENGINE}"
--- MAGENTO_SEARCH_ENGINE_HOST="${SCRIPT_MAGENTO_SEARCH_ENGINE_HOST}"
--- MAGENTO_SEARCH_ENGINE_PORT="${SCRIPT_MAGENTO_SEARCH_ENGINE_PORT}"
--- MYSQL_ROOT_PASSWORD="${SCRIPT_MYSQL_ROOT_PASSWORD}"
--- NGINX_WORKER_PROCESSES="${SCRIPT_NGINX_WORKER_PROCESSES}"
--- NGINX_WORKER_CONNECTIONS="${SCRIPT_NGINX_WORKER_CONNECTIONS}" 


## Changelog

Detailed changes for each release are documented in [`CHANGELOG.md`](./CHANGELOG.md).

## License

This work is published under [MIT License](./LICENSE).

## Author

Always happy to receive a greeting on:

- [LinkedIn](https://www.linkedin.com/in/cristian-marcelo-de-picciotto/) 
- [Web](https://d3p1.dev/)
