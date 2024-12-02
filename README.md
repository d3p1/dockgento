<div align=center>

# [DOCKGENTO]

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
[![Release](https://github.com/d3p1/dockgento/actions/workflows/release.yml/badge.svg)](https://github.com/d3p1/dockgento/actions/workflows/release.yml)

</div>

## Introduction

*DOCKER + MAGENTO = DOCKGENTO*

## Usage

It will be detailed how to use this tool. If you would like to have a better understanding of how this tool works under the hood, you can visit the [wiki page](https://github.com/d3p1/dockgento/wiki).

> [!NOTE]
> Also if you experience some issue during the use of this tool, you can visit the [troubleshooting page](https://github.com/d3p1/dockgento/wiki/%5B6%5D-Troubleshooting).

> [!IMPORTANT]
> For now, this tool was only tested in `Debina 12` and requires an environment with `bash` to work properly.

### Prerequisites

User with sudo privileges. See why [here](https://github.com/d3p1/dockgento/wiki/%5B5%5D-Command-script).

Install Git.

```shell
git clone https://github.com/d3p1/dockgento.git && \
chmod +x dockgento/src/bin/setup/installer.sh   && \
./dockgento/src/bin/setup/installer.sh          && \
source ~/.bash_profile                          && \
rm -rf dockgento/
```

Create `.dockgento_profile` file.

```shell
dockgento mage-install
```

```shell
dockgento mage-setup
```

### Development use

```shell
dockgento init development
```

> [!NOTE]
> You should be able to visit MailHog dashboard in `https://${SCRIPT_DOMAIN}:8025`.

### Production use

Create .dockgento_profile:

```shell
export SCRIPT_USER_EMAIL="cmdepicciotto@binacommerce.com"
export SCRIPT_DOMAIN="docky.binacommerce.com"
export SCRIPT_MARIADB_VERSION="10.6"
export SCRIPT_SMTP_HOST=""
export SCRIPT_SMTP_PORT=""
export SCRIPT_PHP_VERSION="8.2"
export SCRIPT_SEARCH_SERVICE="elasticsearch"
export SCRIPT_COMPOSER_MAGENTO_USERNAME="<COMPOSER_MAGENTO_USERNAME>"
export SCRIPT_COMPOSER_MAGENTO_PASSWORD="<COMPOSER_MAGENTO_PASSWORD>"
export SCRIPT_MAGENTO_VERSION="2.4.6"
export SCRIPT_MAGENTO_ADMIN_FIRSTNAME="Test F"
export SCRIPT_MAGENTO_ADMIN_LASTNAME="Test L"
export SCRIPT_DB_DUMP=""
export SCRIPT_COMPOSE_PROFILES="cron"
```

```shell
dockgento init production
```

```shell
dockgento mage-install
```

## Changelog

Detailed changes for each release are documented in [`CHANGELOG.md`](./CHANGELOG.md).

## License

This work is published under [MIT License](./LICENSE).

## Author

Always happy to receive a greeting on:

- [LinkedIn](https://www.linkedin.com/in/cristian-marcelo-de-picciotto/) 
- [Web](https://d3p1.dev/)
