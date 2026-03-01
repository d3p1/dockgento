#!/bin/bash

##
# @description Dockgento command to up the environment
# @author      C. M. de Picciotto <d3p1@d3p1.dev> (https://d3p1.dev/)
# @note        This script was created because, for production environments,
#              it is required to define a new project name for each release.
#              This is because we are sharing the new released source code
#              by named volume (`docroot`) between containers.
#              If we release new source code, it is required to
#              recreate the volume so the old content does not override
#              the released one. To avoid having to recreate the volume,
#              we set a new project name every time the environment is started.
#              In that way, the `docroot` volume will be prefixed with a new
#              project name each time. Because the project name is generated
#              using the current epoch time prefixed with `RELEASE_`,
#              an example of the volume name
#              could be: `RELEASE_1772393938_docroot`.
#              This approach has the advantage of creating new resources
#              each time a new release is deployed,
#              so it is easier to do rollbacks. However, this is also
#              a disadvantage because every release consumes disk space
#              and it is important to purge things from time to time.
# @todo        For now, the approach of this command works.
#              However, it is better to avoid sharing source code between
#              containers with a named volume. Instead, containers must
#              be self-contained units and every container that require
#              the source code, should have an specific release image
#              that provides
#              it (one for each of them, or one used by all of them).
#              Currently, it is not desired
#              to add the extra work of maintaining
#              a production image for each required service, but
#              we should take into consideration proceed with
#              this requirement in the future
##

##
# Main
#
# @return void
##
main() {
    if [ "$SCRIPT_MODE" = "production" ]; then
        COMPOSE_PROJECT_NAME="RELEASE_$(date %s)"
        export COMPOSE_PROJECT_NAME
    fi

    docker compose up -d
}

##
# @note Call main
##
main "$@"