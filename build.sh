#!/bin/bash

set -euxo pipefail

# CentOS image comes cleaned of locales, reinstall them
yum -y reinstall glibc-common

yum -y install postgresql-server

# rm postgres data dir to init postgres cleanly on startup
rmdir /var/lib/pgsql/data

yum clean all
