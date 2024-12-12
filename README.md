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

## Prerequisites

Before using this tool, ensure that you have:

- User with `sudo` privileges. Learn more about why this is necessary [here](https://github.com/d3p1/dockgento/wiki/%5B5%5D-Command-script).

- [Git](https://git-scm.com/) installed on your system.

## Installation

To install this tool, run the following command:

```shell
git clone https://github.com/d3p1/dockgento.git && \
chmod +x dockgento/src/bin/setup/installer.sh   && \
./dockgento/src/bin/setup/installer.sh          && \
source ~/.bash_profile                          && \
rm -rf dockgento/
```

## Usage

Using this tool is straightforward:

1. Create a [`.dockgento_profile` file](https://github.com/d3p1/dockgento/blob/v1.11.4/src/bin/etc/.dockgento_profile.sample). This file lets you configure environment variables that define how the project environment should be generated.

2. Execute `dockgento init` to generate the necessary [Docker Compose](https://docs.docker.com/compose/) files for the project.

3. Execute `dockgento mage-install` if you want to install a new Magento platform to work with the current generated environment. Or execute `dockgento mage-setup` if you want to configure an existing Magento project to work with the current environment.

> [!NOTE]
> To gain a deeper understanding of how this tool works under the hood, visit the [wiki page](https://github.com/d3p1/dockgento/wiki).

> [!NOTE]
> If you encounter issues while using this tool, refer to the [troubleshooting page](https://github.com/d3p1/dockgento/wiki/%5B8%5D-Troubleshooting) for guidance.

> [!IMPORTANT]
> Please note that [as of now](https://github.com/d3p1/dockgento/issues/8), this tool has only been tested on `Debian 12` and requires an environment with `bash` to function correctly.

## Changelog

Detailed changes for each release are documented in [`CHANGELOG.md`](./CHANGELOG.md).

## License

This work is published under [MIT License](./LICENSE).

## Author

Always happy to receive a greeting on:

- [LinkedIn](https://www.linkedin.com/in/cristian-marcelo-de-picciotto/) 
- [Web](https://d3p1.dev/)
