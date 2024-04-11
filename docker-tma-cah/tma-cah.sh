#!/bin/bash

# This script is run in the `tma-cah` container at build time, starting in the `/project` directory.

set -e
echo "[${0##*/}] Importing live copy of \`cah_cards.sql\` into \`/docker-entrypoint-initdb.d\`."

# Copy SQL dump file from the CustomCAH repo into the shared mount point (defined in Dockerfile) to make it accessible to the `postgres` container
cp -f /project/cah_cards.sql /docker-entrypoint-initdb.d/


echo "[${0##*/}] Building project with Maven. Using \`build.properties\` and \`secure.properties\` overrides."

# Copy overides (if one of these `overrides` files is missing, fallback to loading `build.properties.example` only)
cat build.properties.example /overrides/build.properties /overrides/secure.properties > build.properties  2>/dev/null || cp build.properties.example build.properties
# Build
mvn clean package war:exploded -Dhttps.protocols=TLSv1.2 -Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false 
# Run
mvn jetty:run -Dhttps.protocols=TLSv1.2 -Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false