#!/bin/bash

# This script is run in the container at build time, starting in the `/project` directory.

set -e
echo "Using build.properties overrides"

# Copy SQL dump file from the CustomCAH repo into the shared mount point (defined in Dockerfile) to make it accessible to the `postgres` container
cp -f /project/cah_cards.sql /docker-entrypoint-initdb.d/

# Copy overides (if one of these `overrides` files is missing, fallback to loading `build.properties.example` only)
cat build.properties.example /overrides/build.properties /overrides/secure.properties > build.properties  2>/dev/null || cp build.properties.example build.properties
# Build
mvn clean package war:exploded -Dhttps.protocols=TLSv1.2 -Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false 
# Run
mvn jetty:run -Dhttps.protocols=TLSv1.2 -Dmaven.buildNumber.doCheck=false -Dmaven.buildNumber.doUpdate=false