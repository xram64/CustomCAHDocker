# Dockerfile for `postgres` service of CustomCAHDocker.

FROM postgres:alpine

LABEL xram.tma.cah="postgres"

# Copy build script into the container, fix line endings, and set permissions.
ADD docker-postgres/postgres.sh /
RUN apk add dos2unix --no-cache --repository http://dl-3.alpinelinux.org/alpine/v3.9/community/ --allow-untrusted \
  && dos2unix /postgres.sh \
  && apk del dos2unix \
  && chmod +x /postgres.sh

VOLUME [ "/overrides" ]

# Run the build script.
CMD [ "/postgres.sh" ]