#!/bin/bash
# Stop and remove the Docker containers for CustomCAH.
# xram | 3/28/24

DO_UPDATE=false

HELP_TEXT='Stops and removes Docker containers for CustomCAH. When updating, add (-u) to also force-clear the build cache.\n'
HELP_TEXT+='Options:\n'
HELP_TEXT+='  [-u]        Prepare for a container update (force-clear the build cache).\n'
HELP_TEXT+='  [-h]        Show help text.\n'

while getopts 'uh' opt; do
    case $opt in
        u) DO_UPDATE=true ;;
        h) echo -e "$HELP_TEXT"; exit 2 ;;
    esac
done

# Move into folder with Dockerfile to enable `compose` commands.
# (Only needed if script is outside of this folder.)
# cd /srv/cah/CustomCAHDocker

# Stop all related containers and networks.
echo "[Stopping containers...]"
docker compose stop
docker compose down

# Prune build cache if `-u` is provided.
if [ "$DO_UPDATE" = true ]; then
    echo "[Pruning build cache...]"
    docker builder prune -a -f
fi