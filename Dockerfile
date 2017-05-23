# Builds a Docker image with Ubuntu 16.04, Octave, Python3 and Jupyter Notebook
# for "AMS 595: Fundamental of Computing" at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/ubuntu:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Install system packages
RUN add-apt-repository ppa:webupd8team/atom && \
    apt-add-repository ppa:octave/stable && \
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
    apt-get install -y --no-install-recommends \
        octave \
        gnuplot-x11 \
        liboctave-dev \
        libopenblas-base \
        libatlas3-base \
        pstoedit \
        octave-info && \
    apt-get install -y --no-install-recommends \
        python3-pip \
        python3-dev \
        pandoc \
        ttf-dejavu && \
    apm install language-matlab linter-matlab git-plus merge-conflicts split-diff python-autopep8 && \
    pip install -U sympy && \
    octave --eval 'pkg install -forge struct parallel symbolic odepkg' && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SciPy, SymPy, Pandas, and Jupyter Notebook for Python3 and Octave
RUN pip3 install -U pip \
         setuptools && \
    pip3 install -U \
         numpy \
         matplotlib \
         sympy \
         scipy \
         pandas \
         nose \
         sphinx \
         autopep8 \
         flufl.lock \
         ply \
         pytest \
         six \
         PyQt5 \
         spyder \
         urllib3 && \
    pip3 install -U \
         jupyter \
         ipywidgets && \
    jupyter nbextension install --py --system \
         widgetsnbextension && \
    jupyter nbextension enable --py --system \
         widgetsnbextension && \
    pip3 install -U \
        jupyter_latex_envs==1.3.8.4 && \
    jupyter nbextension install --py --system \
        latex_envs && \
    jupyter nbextension enable --py --system \
        latex_envs && \
    jupyter nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-spell-check-1.0.zip && \
    jupyter nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-document-tools-1.0.zip && \
    jupyter nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-cell-tools-1.0.zip && \
    jupyter nbextension enable --system \
        calico-spell-check && \
    pip3 install -U octave_kernel && \
    python3 -m octave_kernel.install && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
    touch $DOCKER_HOME/.log/jupyter.log && \
    touch $DOCKER_HOME/.log/vnc.log && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME

USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","/sbin/setuser","ams595","/bin/bash","-l","-c"]
CMD ["/bin/bash","-l","-i"]
