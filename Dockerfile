# Builds a Docker image with Ubuntu 16.04, Octave, Python3 and Jupyter Notebook
# for "AMS 595: Fundamental of Computing" at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM compdatasci/octave-desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Install system packages
RUN add-apt-repository ppa:webupd8team/atom && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        gdb \
        ddd \
        valgrind \
        electric-fence \
        ccache \
        \
        liblapack-dev \
        libmpich-dev \
        libopenblas-dev \
        mpich \
        \
        meld \
        atom \
        clang-format && \
    apt-get clean && \
    pip install sympy && \
    pip3 install -U \
         autopep8 \
         flake8 \
         PyQt5 \
         spyder && \
    octave --eval 'pkg install -forge symbolic' && \
    mkdir -p /usr/local/mlint && \
    curl -L https://goo.gl/ExjLDP | bsdtar zxf - -C /usr/local/mlint --strip-components 4 && \
    ln -s -f /usr/local/mlint/bin/glnxa64/mlint /usr/local/bin && \
    rm -rf /var/lib/apt/lists/* /tmp/*

########################################################
# Customization for user
########################################################

ADD image/etc /etc
ADD image/bin $DOCKER_HOME/bin
ADD image/config $DOCKER_HOME/.config

# Install gdutil and set permission
RUN git clone --depth 1 https://github.com/hpdata/gdutil /usr/local/gdutil && \
    pip2 install -r /usr/local/gdutil/requirements.txt && \
    pip3 install -r /usr/local/gdutil/requirements.txt && \
    ln -s -f /usr/local/gdutil/gd_get_pub.py /usr/local/bin/gd-get-pub && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

USER $DOCKER_USER
ENV  GIT_EDITOR=vi EDITOR=atom
RUN echo "@start_matlab" >> $DOCKER_HOME/.config/lxsession/LXDE/autostart && \
    echo 'export OMP_NUM_THREADS=$(nproc)' >> $DOCKER_HOME/.profile && \
    apm install \
        language-cpp14 \
        language-matlab \
        language-fortran \
        language-docker \
        autocomplete-python \
        autocomplete-fortran \
        git-plus \
        merge-conflicts \
        split-diff \
        gcc-make-run \
        platformio-ide-terminal \
        intentions \
        busy-signal \
        linter-ui-default \
        linter \
        linter-gcc \
        linter-gfortran \
        linter-flake8 \
        linter-matlab \
        dbg \
        output-panel \
        dbg-gdb \
        python-debugger \
        auto-detect-indentation \
        python-autopep8 \
        clang-format && \
    ln -s -f $DOCKER_HOME/.config/atom/* $DOCKER_HOME/.atom && \
    ln -s -f $DOCKER_HOME/.config/matlab $DOCKER_HOME/.matlab && \
    rm -rf /tmp/* && \
    echo "PATH=$DOCKER_HOME/bin:/usr/local/gdutil/bin:$PATH" >> $DOCKER_HOME/.profile


WORKDIR $DOCKER_HOME
USER root
