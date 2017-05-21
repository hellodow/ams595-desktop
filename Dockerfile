# Builds a Docker image for "AMS 595: Fundamental of Computing"
# at Stony Brook University with Ubuntu, LXDE, and Atom.
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/ubuntu:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Install system packages
RUN add-apt-repository ppa:webupd8team/atom && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gfortran \
        cmake \
        bison \
        flex \
        git \
        bash-completion \
        bsdtar \
        rsync \
        wget \
        gdb \
        ddd \
        electric-fence \
        gfortran \
        pkg-config \
        ccache \
        \
        liblapack-dev \
        libmpich-dev \
        libopenblas-dev \
        mpich \
        \
        meld \
        atom && \
    apm install language-matlab linter-matlab git-plus merge-conflicts split-diff python-autopep8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

########################################################
# Customization for user
########################################################
ENV CDS_USER=ams595
ENV DOCKER_USER=$CDS_USER \
    DOCKER_GROUP=$CDS_USER \
    DOCKER_HOME=/home/$CDS_USER \
    HOME=/home/$CDS_USER

RUN usermod -l $DOCKER_USER -d $DOCKER_HOME -m x11vnc && \
    groupmod -n $DOCKER_USER x11vnc && \
    echo "$DOCKER_USER:docker" | chpasswd && \
    echo "$DOCKER_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "export OMP_NUM_THREADS=\$(nproc)" >> $DOCKER_HOME/.profile && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME

USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","/sbin/setuser","numgeom","/bin/bash","-l","-c"]
CMD ["/bin/bash","-l","-i"]
