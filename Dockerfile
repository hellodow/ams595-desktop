# Builds a Docker image with Valgrind and kcachegrind in addition to the base image
# for "AMS 595: Fundamental of Computing" at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM ams595/desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Install valgrind
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gdb \
        ddd \
        valgrind \
        electric-fence \
        kcachegrind && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

WORKDIR $DOCKER_HOME
