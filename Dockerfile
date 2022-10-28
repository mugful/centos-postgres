#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.


# TODO: When updating to CentOS Stream 9, switch container_postgres
# from using su to using sudo, and install sudo. Neither su nor sudo
# is available by default in Stream 9.
FROM quay.io/centos/centos:stream8
MAINTAINER Jiri Stransky <jistr@jistr.com>

RUN dnf clean expire-cache && dnf -y update && dnf clean all

COPY build.sh /root/build.sh
RUN /root/build.sh

COPY files /

VOLUME ["/var/lib/pgsql"]
EXPOSE 5432

CMD ["/usr/local/bin/container_postgres"]
