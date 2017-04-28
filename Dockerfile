# Builds a Docker image for development environment
# with Ubuntu, LXDE, PETSc, and Atom.
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/ubuntu:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Environment variables
ENV PETSC_VERSION=3.7.5 \
    OPENBLAS_NUM_THREADS=1 \
    OPENBLAS_VERBOSE=0

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
        gfortran \
        pkg-config \
        ccache \
        \
        libboost-filesystem-dev \
        libboost-iostreams-dev \
        libboost-program-options-dev \
        libboost-system-dev \
        libboost-thread-dev \
        libboost-timer-dev \
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

# Install PETSc from source.
RUN curl -s http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${PETSC_VERSION}.tar.gz | \
    tar zx && \
    cd petsc-${PETSC_VERSION} && \
    ./configure --COPTFLAGS="-O2" \
                --CXXOPTFLAGS="-O2" \
                --FOPTFLAGS="-O2" \
                --with-blas-lib=/usr/lib/libopenblas.a --with-lapack-lib=/usr/lib/liblapack.a \
                --with-c-support \
                --with-debugging=0 \
                --with-shared-libraries \
                --download-suitesparse \
                --download-superlu \
                --download-superlu_dist \
                --download-scalapack \
                --download-metis \
                --download-parmetis \
                --download-ptscotch \
                --download-hypre \
                --download-mumps \
                --download-blacs \
                --download-spai \
                --download-ml \
                --prefix=/usr/local/petsc-32 && \
     make && \
     make install && \
     rm -rf /tmp/* /var/tmp/*

ENV PETSC_DIR=/usr/local/petsc-32

########################################################
# Customization for user
########################################################
ENV NG_USER=numgeom

RUN usermod -l $NG_USER -d /home/$NG_USER -m $DOCKER_USER && \
    groupmod -n $NG_USER $DOCKER_USER && \
    echo "$NG_USER:docker" | chpasswd && \
    echo "$NG_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sed -i "s/$DOCKER_USER/$NG_USER/" /home/$NG_USER/.config/pcmanfm/LXDE/desktop-items-0.conf && \
    echo "export OMP_NUM_THREADS=\$(nprocs)" >> /home/$NG_USER/.profile && \
    chown -R $NG_USER:$NG_USER /home/$NG_USER

ENV DOCKER_USER=$NG_USER \
    DOCKER_GROUP=$NG_USER \
    DOCKER_HOME=/home/$NG_USER \
    HOME=/home/$NG_USER

WORKDIR $DOCKER_HOME

USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","/sbin/setuser","numgeom","/bin/bash","-l","-c"]
CMD ["/bin/bash","-l","-i"]
