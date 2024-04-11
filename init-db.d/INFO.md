# /init-db.d

- This folder originally held the `cah_cards.sql` dump that is copied into to the `postgres` container service and could be used to update the DB.
- This folder is mounted into the container using a `- ./init-db.d:/docker-entrypoint-initdb.d` line under `services > postgres > volumes` in `docker-compose.yml`.

- The modified `cah_cards.sql` dump file stored in the `CustomCAH` repo is now added to this folder at build time via the override build script `docker-tma-cah/tma-cah.sh`.
- Any other SQL or `.sh` script files in this folder will be executed by the container at build time, in alphabetical filename order.


## [`postgres`](https://hub.docker.com/_/postgres) Docker image

> **Initialization scripts**
> 
> If you would like to do additional initialization in an image derived from this one, add one or more *.sql, *.sql.gz, or *.sh scripts under /docker-entrypoint-initdb.d (creating the directory if necessary). After the entrypoint calls initdb to create the default postgres user and database, it will run any *.sql files, run any executable *.sh scripts, and source any non-executable *.sh scripts found in that directory to do further initialization before starting the service.
> 
> Warning: scripts in /docker-entrypoint-initdb.d are only run if you start the container with a data directory that is empty; any pre-existing database will be left untouched on container startup. One common problem is that if one of your /docker-entrypoint-initdb.d scripts fails (which will cause the entrypoint script to exit) and your orchestrator restarts the container with the already initialized data directory, it will not continue on with your scripts.
>
> These initialization files will be executed in sorted name order as defined by the current locale, which defaults to en_US.utf8. Any *.sql files will be executed by POSTGRES_USER, which defaults to the postgres superuser. It is recommended that any psql commands that are run inside of a *.sh script be executed as POSTGRES_USER by using the --username "$POSTGRES_USER" flag. This user will be able to connect without a password due to the presence of trust authentication for Unix socket connections made inside the container.
>
> Additionally, as of docker-library/postgres#253, these initialization scripts are run as the postgres user (or as the "semi-arbitrary user" specified with the --user flag to docker run; see the section titled "Arbitrary --user Notes" for more details). Also, as of docker-library/postgres#440, the temporary daemon started for these initialization scripts listens only on the Unix socket, so any psql usage should drop the hostname portion (see docker-library/postgres#474 (comment) for example).
