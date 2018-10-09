# Copyright 2017 Red Hat
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ------------------------------------------------------------------------
#
# This is a Dockerfile for the rimolive/openshift-zeppelin:1.3 image.

FROM radanalyticsio/openshift-spark:2.3.0-4

# Environment variables
ENV JBOSS_IMAGE_NAME="rimolive/openshift-zeppelin" \
    JBOSS_IMAGE_VERSION="1.3" \
    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/zeppelin/bin:/opt/miniconda/bin" \
    ZEPPELIN_HOME="/opt/zeppelin" \
    APP_ROOT="/opt/app-root" \
    STI_SCRIPTS_PATH="/usr/libexec/s2i" 

# Labels
LABEL name="$JBOSS_IMAGE_NAME" \
      version="$JBOSS_IMAGE_VERSION" \
      architecture="x86_64"  \
      com.redhat.component="rimolive-openshift-zeppelin-docker"  \
      io.k8s.description="A web-based notebook that enables interactive data analytics" \
      io.k8s.display-name="Apache Zeppelin" \
      io.openshift.expose-services="8080:http,42000:http,42100:http" \
      io.openshift.tags="radanalytics,apache_zeppelin,notebook" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      org.concrt.version="1.4.1"

# Exposed ports
EXPOSE 8080

USER root


# Install required RPMs and ensure that the packages were installed
RUN yum install -y  epel-release gcc python python-devel bzip2 \
    && yum clean all && \
    rpm -q  epel-release gcc python python-devel bzip2

# Add all artifacts to the /tmp/artifacts
# directory
COPY \
    zeppelin-0.8.0-bin-netinst.tgz \
    /tmp/artifacts/

# Add scripts used to configure the image
COPY modules /tmp/scripts

# Custom scripts
USER root
RUN [ "bash", "-x", "/tmp/scripts/zeppelin/run" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/pyspark/run" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/cassandra/run" ]

USER root
RUN [ "bash", "-x", "/tmp/scripts/s2i-interpreters/run" ]

USER root
RUN rm -rf /tmp/scripts
USER root
RUN rm -rf /tmp/artifacts

USER 185



CMD ["/opt/zeppelin/bin/zeppelin.sh"]
