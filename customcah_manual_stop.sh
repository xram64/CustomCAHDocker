#!/bin/bash
# Stop and remove the Docker containers for CustomCAH.
# xram | 3/28/24 | v1.0 (4/11/24)

DO_PRUNE_BUILD=false
DO_PRUNE_IMAGES=false
DO_FULL_UPDATE=false

HELP_TEXT='Stops and removes Docker containers for CustomCAH.\n'
HELP_TEXT+='Options:\n'
HELP_TEXT+='  [-b]        Also force-clear the build cache.\n'
HELP_TEXT+='  [-i]        Also force-clear all cached layers of tagged images.\n'
HELP_TEXT+='  [-u]        Prepare for a full update (implies both -b and -i).\n'
HELP_TEXT+='  [-h]        Show help text.\n'

while getopts 'biuh' opt; do
    case $opt in
        b) DO_PRUNE_BUILD=true ;;
        i) DO_PRUNE_IMAGES=true ;;
        u) DO_FULL_UPDATE=true ;;
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

# Prune build cache if `-b` or `-u` is provided.
if [ "$DO_PRUNE_BUILD" = true ] || [ "$DO_FULL_UPDATE" = true ]; then
    echo "[Pruning build cache...]"
    docker builder prune -a -f
fi

# Prune images if `-i` or `-u` is provided.
if [ "$DO_PRUNE_IMAGES" = true ] || [ "$DO_FULL_UPDATE" = true ]; then
    echo "[Pruning images...]"
    docker image prune -a -f --filter "label=xram.tma.cah"
fi
