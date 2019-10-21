# Copyright 2019 Red Hat
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
# This is a Dockerfile for the zeppelin-openshift:1.3 image.


## START target image zeppelin-openshift:1.3
## \
    FROM radanalyticsio/openshift-spark:2.4-latest

    USER root

###### START module 'zeppelin:1.0'
###### \
        # Copy 'zeppelin' module general artifacts
        COPY \
            zeppelin-0.8.2-bin-netinst.tgz \
            /tmp/artifacts/
        # Copy 'zeppelin' module content
        COPY modules/zeppelin /tmp/scripts/zeppelin
        # Switch to 'root' user to install 'zeppelin' module defined packages
        USER root
        # Install packages defined in the 'zeppelin' module
        RUN yum --setopt=tsflags=nodocs install -y epel-release gcc python python-devel bzip2 \
            && rpm -q epel-release gcc python python-devel bzip2
        # Set 'zeppelin' module defined environment variables
        ENV \
            APP_ROOT="/opt/app-root" \
            PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/zeppelin/bin:/opt/miniconda/bin" \
            STI_SCRIPTS_PATH="/usr/libexec/s2i" \
            ZEPPELIN_HOME="/opt/zeppelin" 
        # Custom scripts from 'zeppelin' module
        USER root
        RUN [ "bash", "-x", "/tmp/scripts/zeppelin/run" ]
###### /
###### END module 'zeppelin:1.0'

###### START module 'pyspark:1.0'
###### \
        # Copy 'pyspark' module content
        COPY modules/pyspark /tmp/scripts/pyspark
        # Custom scripts from 'pyspark' module
        USER root
        RUN [ "bash", "-x", "/tmp/scripts/pyspark/run" ]
###### /
###### END module 'pyspark:1.0'

###### START module 'cassandra:1.0'
###### \
        # Copy 'cassandra' module content
        COPY modules/cassandra /tmp/scripts/cassandra
        # Custom scripts from 'cassandra' module
        USER root
        RUN [ "bash", "-x", "/tmp/scripts/cassandra/run" ]
###### /
###### END module 'cassandra:1.0'

###### START module 's2i-interpreters:1.0'
###### \
        # Copy 's2i-interpreters' module content
        COPY modules/s2i-interpreters /tmp/scripts/s2i-interpreters
        # Custom scripts from 's2i-interpreters' module
        USER root
        RUN [ "bash", "-x", "/tmp/scripts/s2i-interpreters/run" ]
###### /
###### END module 's2i-interpreters:1.0'

###### START image 'zeppelin-openshift:1.3'
###### \
        # Set 'zeppelin-openshift' image defined environment variables
        ENV \
            JBOSS_IMAGE_NAME="zeppelin-openshift" \
            JBOSS_IMAGE_VERSION="1.3" 
        # Set 'zeppelin-openshift' image defined labels
        LABEL \
            io.cekit.version="3.5.0"  \
            io.k8s.description="A web-based notebook that enables interactive data analytics"  \
            io.k8s.display-name="Apache Zeppelin"  \
            io.openshift.expose-services="8080:http,42000:http,42100:http"  \
            io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"  \
            io.openshift.tags="radanalytics,apache_zeppelin,notebook"  \
            name="zeppelin-openshift"  \
            version="1.3" 
        # Exposed ports in 'zeppelin-openshift' image
        EXPOSE 8080
###### /
###### END image 'zeppelin-openshift:1.3'


    # Switch to 'root' user and remove artifacts and modules
    USER root
    RUN [ ! -d /tmp/scripts ] || rm -rf /tmp/scripts
    RUN [ ! -d /tmp/artifacts ] || rm -rf /tmp/artifacts

    # Clear package manager metadata
    RUN yum clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum

    # Define the user
    USER 185
    # Define run cmd
    CMD ["/opt/zeppelin/bin/zeppelin.sh"]
## /
## END target image