<div align=center>

# [DOCKGENTO]

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
[![Release](https://github.com/d3p1/dockgento/actions/workflows/release.yml/badge.svg)](https://github.com/d3p1/dockgento/actions/workflows/release.yml)

</div>

## Introduction

Just another [Docker](https://www.docker.com/) environment generator for [Magento](https://business.adobe.com/products/magento/open-source.html).

The main idea behind this tool is to have an automatic way to generate [Magento](https://business.adobe.com/products/magento/open-source.html) environments for development, but also for production. To support this, [Traefik](https://doc.traefik.io/traefik/) has been included to the tech stack, enabling SSL termination and simplifying the generation of SSL certificates for live sites.

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

1. Create a [`.dockgento_profile` file](https://github.com/d3p1/dockgento/blob/main/src/bin/etc/.dockgento_profile.sample). This file lets you configure environment variables that define how the project environment should be generated.

2. Execute `dockgento init` to generate the necessary [Docker Compose](https://docs.docker.com/compose/) files for the project.

3. Execute `dockgento mage-install` if you want to install a new Magento platform to work with the current generated environment. 

4. Execute `dockgento mage-configure` to configure the Magento project to work with the current environment. This will execute a final setup so the existing Magento project is ready to work with the generated environment.

5. Execute `dockgento ide-configure` to simplify the configuration of your IDE, allowing you to work with this generated environment efficiently and effectively.

6. Finally, execute `dockgento up` to start the generated environment. 

> [!NOTE]
> A recommended release approach could be:
> 1. In your local/CI environment, pull latest code from the repository.
> 2. Build the `web` image.
> 3. Push `web` image to the registry.
> 4. In your production environment, execute `dockgento up`. 

> [!NOTE]
> When starting the production environment, because the [`pull_policy` is set to `always` for the `web` service](https://github.com/d3p1/dockgento/blob/main/src/bin/etc/docker-compose.prod.yml#L28), the latest image will be pulled and used.

> [!NOTE]
> Please note that the [platform image does not exclude `<doc-root>/app/etc/env.php`](https://docs.docker.com/build/concepts/context/#dockerignore-files). Therefore, you should avoid storing sensitive information in this file for public images. In addition to storing them in the database, you can also [use environment variables to manage sensitive data securely](https://experienceleague.adobe.com/en/docs/commerce-operations/configuration-guide/paths/override-config-settings).

> [!NOTE]
> If you use [GitHub Actions](https://github.com/features/actions) to automate your development and delivery workflow, you can use the [`d3p1/semantic-releasify` action](https://github.com/d3p1/semantic-releasify/) to publish the `web` image on every release.

> [!IMPORTANT]
> The source code of the project must live in a child directory of the directory where the `dockgento init` is executed. This is because Docker only can access build context from the directory where the `docker-compose.yml` file is located, and the production image must copy the app source code to then build it and start the app.   
> Additioanlly, the `dockgento ide-configure` for [PhpStorm](https://www.jetbrains.com/phpstorm/) considers that the source code lives in a child directory to configure the startup scripts ([`Dev`](https://github.com/d3p1/dockgento/blob/2be6649c49fa3eb4321ac657906cc78b396013a0/src/bin/etc/.idea/runConfigurations/Dev.xml#L8) and [`Cache`](https://github.com/d3p1/dockgento/blob/2be6649c49fa3eb4321ac657906cc78b396013a0/src/bin/etc/.idea/runConfigurations/Cache.xml#L8)).

> [!IMPORTANT]
> For now, `dockgento ide-configure` only installs [startup scripts](https://www.jetbrains.com/help/phpstorm/settings-tools-startup-tasks.html) that are very useful for [PhpStorm](https://www.jetbrains.com/phpstorm/). However, automating the configuration of other important aspects and supporting additional IDEs is still pending. [This ticket](https://github.com/d3p1/dockgento/issues/10) and [this ticket](https://github.com/d3p1/dockgento/issues/17) will handle the completion of this requirement.

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
