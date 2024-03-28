#!/bin/bash
# Start the Docker containers for CustomCAH.
# xram | 3/28/24

HELP_TEXT='Starts Docker containers for CustomCAH.\n'
HELP_TEXT+='Options:\n'
HELP_TEXT+='  [-h]        Show help text.\n'

while getopts 'h' opt; do
    case $opt in
        h) echo -e "$HELP_TEXT"; exit 2 ;;
    esac
done

# Move into folder with Dockerfile to enable `compose` commands.
# (Only needed if script is outside of this folder.)
# cd /srv/cah/CustomCAHDocker

# Start related containers and networks.
docker compose up -d --build