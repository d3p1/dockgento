<div align=center>

# [DOCKGENTO]

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
[![Release](https://github.com/d3p1/dockgento/actions/workflows/release.yml/badge.svg)](https://github.com/d3p1/dockgento/actions/workflows/release.yml)

</div>

## Introduction

Just another [Docker](https://www.docker.com/) environment generator for [Magento](https://business.adobe.com/products/magento/open-source.html).

The main idea behind this tool is to have an automatic way to generate [Magento](https://business.adobe.com/products/magento/open-source.html) environments for development, but also for production. To support this, [Traefik](https://doc.traefik.io/traefik/) has been included to the tech stack, enabling SSL termination and simplifying the generation of SSL certificates for live sites.

It is worth mentioning that this tool was inspired by other excellent tools that achieve similar goals, including:

- [Mark Shust's Docker Magento](https://github.com/markshust/docker-magento)
- [Warden](https://docs.warden.dev/environments/magento2.html)

> [!NOTE]
> [Mark Shust's Docker Magento](https://github.com/markshust/docker-magento) also provides great video tutorials on configuring your IDE to work seamlessly with Docker.

## Usage

Using this tool is straightforward:

1. Install `dockgento`.

2. Create a [`.dockgento_profile` file](https://github.com/d3p1/dockgento/blob/main/src/bin/etc/.dockgento_profile.sample). This file lets you configure environment variables that define how the project environment should be generated.

3. Execute `dockgento init <environment>` to generate the necessary [Docker Compose](https://docs.docker.com/compose/) files for the project.

4. Execute `dockgento mage-install` if you want to install a new Magento platform to work with the current generated environment. Or execute `dockgento mage-setup` if you want to configure an existing Magento project to work with the current environment.

> [!NOTE]
> To gain a deeper understanding of how this tool works under the hood, visit the [wiki page](https://github.com/d3p1/dockgento/wiki).

> [!NOTE]
> If you encounter issues while using this tool, refer to the [troubleshooting page](https://github.com/d3p1/dockgento/wiki/%5B6%5D-Troubleshooting) page for guidance.

> [!IMPORTANT]
> Please note that [as of now](https://github.com/d3p1/dockgento/issues/8), this tool has only been tested on `Debian 12` and requires an environment with `bash` to function correctly.

### Prerequisites

Before using this tool, ensure that you have:

- User with `sudo` privileges. Learn more about why this is necessary [here](https://github.com/d3p1/dockgento/wiki/%5B5%5D-Command-script).

- [Git](https://git-scm.com/) installed on you system.

### Installation

To install this tool, run the following command:

```shell
git clone https://github.com/d3p1/dockgento.git && \
chmod +x dockgento/src/bin/setup/installer.sh   && \
./dockgento/src/bin/setup/installer.sh          && \
source ~/.bash_profile                          && \
rm -rf dockgento/
```

### Development usage example

Assuming `dockgento` is already installed, and I want to create a development site pointing to the domain `magento.test`, the steps are as follows:

In the folder where I want to host the environment files, I need to create a [`.dockgento_profile`](https://github.com/d3p1/dockgento/blob/main/src/bin/etc/.dockgento_profile.dev.sample):

```shell
export SCRIPT_USER_EMAIL="d3p1@d3p1.dev"
export SCRIPT_DOMAIN="magento.test"
export SCRIPT_MARIADB_VERSION="10.6"
export SCRIPT_PHP_SENDMAIL_PATH="/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025"
export SCRIPT_PHP_VERSION="8.2"
export SCRIPT_SEARCH_SERVICE="elasticsearch"
export SCRIPT_COMPOSER_MAGENTO_USERNAME=""
export SCRIPT_COMPOSER_MAGENTO_PASSWORD=""
export SCRIPT_MAGENTO_VERSION="2.4.6"
export SCRIPT_MAGENTO_ADMIN_FIRSTNAME="Test Firstname"
export SCRIPT_MAGENTO_ADMIN_LASTNAME="Test Lastname"
export SCRIPT_MAGENTO_ADMIN_USER="test"
export SCRIPT_MAGENTO_ADMIN_PASSWORD="Test123456."
export SCRIPT_DEV_DOC_ROOT_DIR="./www"
export SCRIPT_DB_DUMP=""
export SCRIPT_COMPOSE_PROFILES=""
```

Then, I can intialize the environment using the command:

```shell
dockgento init development
```

Finally, to install a new Magento platform, I can run the following command:

```shell
dockgento mage-install
```

You should now be able to access the platform at `https://magento.test/` and the test SMTP server dashboard at `https://magento.test:8025/`.

> [!NOTE]
> The environment can be managed like any other [Docker Compose](https://docs.docker.com/compose/) environment.

### Production usage example

Assuming `dockgento` is already installed and the `DNS` records are pointing to the live server, I want to create a live site for the domain `magento.live`. The steps are as follows:

In the folder where I want to host the environment files, I need to create a [`.dockgento_profile`](https://github.com/d3p1/dockgento/blob/main/src/bin/etc/.dockgento_profile.prod.sample):

```shell
export SCRIPT_USER_EMAIL="d3p1@d3p1.dev"
export SCRIPT_DOMAIN="magento.live"
export SCRIPT_MARIADB_VERSION="10.6"
export SCRIPT_SMTP_HOST=""
export SCRIPT_SMTP_PORT=""
export SCRIPT_PHP_VERSION="8.2"
export SCRIPT_SEARCH_SERVICE="elasticsearch"
export SCRIPT_COMPOSER_MAGENTO_USERNAME="<COMPOSER_MAGENTO_USERNAME>"
export SCRIPT_COMPOSER_MAGENTO_PASSWORD="<COMPOSER_MAGENTO_PASSWORD>"
export SCRIPT_MAGENTO_VERSION="2.4.6"
export SCRIPT_MAGENTO_ADMIN_FIRSTNAME="Cristian Marcelo"
export SCRIPT_MAGENTO_ADMIN_LASTNAME="de Picciotto"
export SCRIPT_DB_DUMP=""
export SCRIPT_COMPOSE_PROFILES="cron"
```

Then, I can intialize the environment using the command:

```shell
dockgento init production
```

Finally, to install a new Magento platform, I can run the following command:

```shell
dockgento mage-install
```

You should now be able to access the platform at `https://magento.live/`.

> [!NOTE]
> The environment can be managed like any other [Docker Compose](https://docs.docker.com/compose/) environment.

## Changelog

Detailed changes for each release are documented in [`CHANGELOG.md`](./CHANGELOG.md).

## License

This work is published under [MIT License](./LICENSE).

## Author

Always happy to receive a greeting on:

- [LinkedIn](https://www.linkedin.com/in/cristian-marcelo-de-picciotto/) 
- [Web](https://d3p1.dev/)
