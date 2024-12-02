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
-- *How to enable `cron` and `cli` container using the `COMPOSE_PROFILE` environment variable*
-- *That the CLI was only tested in `Debian 12` and requires `bash`*
-- *Explain the it is possible to use just `docker compose up -d` because it is used the environment variable `COMPOSE_FILE` inside the `.env` to the define the respective `Docker Compose` files to use taking into consideration the environment defined*
-- *Document the one line to installer the CLI: `git clone https://github.com/d3p1/dockgento.git && chmod +x dockgento/src/bin/setup/installer.sh && ./dockgento/src/bin/setup/installer.sh && source ~/.bash_profile && rm -rf dockgento/`*
-- *Document that to access `mailhog` mail service in development environment, it is used the platform domain and the port `8025`* 
-- *Document that to Docker rootless installation, avoid switching to user using `sudo` and `su` because known error: https://github.com/docker/docs/issues/14491 - https://unix.stackexchange.com/questions/587674/systemd-not-detected-dockerd-daemon-needs-to-be-started-manually* 
-- *Document that `dockgento` will ask for `sudo` password because there are certain operation that requires it (like editing the `/etc/hosts` file)* 

## Changelog

Detailed changes for each release are documented in [`CHANGELOG.md`](./CHANGELOG.md).

## License

This work is published under [MIT License](./LICENSE).

## Author

Always happy to receive a greeting on:

- [LinkedIn](https://www.linkedin.com/in/cristian-marcelo-de-picciotto/) 
- [Web](https://d3p1.dev/)
