centos-postgres
===============

A PostgreSQL image built on top of CentOS 7.

Pull
----

Either pull from Quay.io:

    podman pull quay.io/mugful/centos-postgres:master

Or build your own:

    git clone https://github.com/mugful/centos-postgres
    cd centos-postgres
    podman build --force-rm -t mugful/centos-postgres:master .

Run
---

Prepare a directory where you'll have your Postgres data:

    mkdir /var/lib/my-pgsql

    podman run -d \
        --name my_pgsql \
        -v /var/lib/my-pgsql:/var/lib/pgsql:z \
        -p 5432:5432 \
        quay.io/mugful/centos-postgres:master

Now you have a Postgres instance running with its data directory
exported onto the host. You can run psql to login as `postgres` user
and create additional user roles etc.:

    podman exec -i -t -u postgres my_pgsql psql

To stop the server again:

    podman stop my_pgsql

Configuring
-----------

By default the PostgreSQL instance is pretty much locked down,
allowing `ident` authentication method only. If you want to loosen the
restriction by adding additional lines into pg_hba.conf when the
container first initializes the database, you can set the container's
`PG_HBA_LINES` environment variable. Note that this variable takes
effect only when initializing the database from scratch. When starting
the container on an existing data directory, it has no effect.

You may need to play with `listen_addresses` option in postgresql.conf
to make the container reachable e.g. from other containers on the same
host. However, be careful not to expose your container on public
network. (Do not use `host` networking mode and when using `-p` option
for `podman run`, do not map the container port outside localhost.)

To configure the Postgres instance further you can edit the config
files and restart the container.
