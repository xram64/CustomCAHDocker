# /init-db.d

- This folder originally held the `cah_cards.sql` dump that is copied into to the `postgres` container service and could be used to update the DB.
- This folder is mounted into the container using a `- ./init-db.d:/docker-entrypoint-initdb.d` line under `services > postgres > volumes` in `docker-compose.yml`.
- This file is now overwritten at build time with the modified SQL dump file stored in the `CustomCAH` repo, via the override build script `script/tmacah.sh`.