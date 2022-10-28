#!/bin/bash

set -euxo pipefail

# CentOS image comes cleaned of locales, reinstall them
dnf -y reinstall glibc-common

dnf -y install postgresql-server

# rm postgres data dir to init postgres cleanly on startup
rmdir /var/lib/pgsql/data

dnf clean all
