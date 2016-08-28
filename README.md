centos-postgres
===============

A PostgreSQL image built on top of CentOS 7.

Build
-----

    git clone https://github.com/dockingbay/centos-owncloud
    cd centos-owncloud
    docker build --force-rm -t dockingbay/centos-postgres:latest .

Run
---

Prepare a directory where you'll have your Postgres data:

    mkdir /var/lib/my-pgsql

    docker run -d \
        --name my_pgsql \
        -v /var/lib/my-pgsql:/var/lib/pgsql:z \
        -p 5432:5432 \
        dockingbay/centos-postgres:latest

Now you have a Postgres instance running with its data directory
exported onto the host. You can run psql to login as `postgres` user
and create additional user roles etc.:

    docker exec -i -t -u postgres my_pgsql psql

To stop the server again:

    docker stop my_pgsql

Configuring
-----------

By default the PostgreSQL instance is pretty much locked down,
allowing `ident` authentication method only. If you want to loosen the
restriction by adding additional lines into pg_hba.conf when the
container first initializes the database, you can set the container's
`PG_HBA_LINES` environment variable. Note that this variable takes
effect only when initializing the database from scratch. When starting
the container on an existing data directory, it has no effect.

To configure the Postgres instance further you can edit the config
files and restart the container.
