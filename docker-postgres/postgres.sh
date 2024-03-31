#!/bin/bash

# This script is run in the `postgres` container at build time, starting in the `/` directory.

set -e
echo "[postgres.sh] Flushing TMACAH database."
dropdb --if-exists -f -w -U TMA_CAH_PG "TMACAH"

echo "[postgres.sh] Importing \`cah_cards.sql\` into TMACAH database."
createdb -O TMA_CAH_PG -w -U TMA_CAH_PG "TMACAH"
psql -U TMA_CAH_PG -d TMACAH -f /docker-entrypoint-initdb.d/cah_cards.sql