# Builds a Docker image with Ubuntu 18.04, Octave, Python3 and Jupyter Notebook
# for "AMS 595: Fundamental of Computing" at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM compdatasci/octave-desktop:18.04
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

ADD image/home $DOCKER_HOME

# Install system packages
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        gdb \
        ddd \
        valgrind \
        electric-fence \
        kcachegrind \
        ccache \
        libnss3 \
        nano \
        emacs \
        vim \
        \
        liblapack-dev \
        libopenblas-dev \
        libomp-dev \
        \
        meld \
        clang \
        clang-format \
        code && \
    apt-get clean && \
    pip3 install -U \
        numpy \
        scipy \
        sympy \
        pandas \
        matplotlib \
        autopep8 \
        flake8 \
        PyQt5 \
        pylint \
        pytest \
        spyder && \
    echo "move_to_config vscode" >> /usr/local/bin/init_vnc && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

USER $DOCKER_USER
WORKDIR $DOCKER_HOME

# Install mscode extensions
RUN bash -c 'for ext in \
        ms-vscode.cpptools \
        xaver.clang-format \
        cschlosser.doxdocgen \
        bbenoist.doxygen \
        streetsidesoftware.code-spell-checker \
        eamodio.gitlens \
        james-yu.latex-workshop \
        yzhang.markdown-all-in-one \
        davidanson.vscode-markdownlint \
        gimly81.matlab \
        krvajalm.linter-gfortran \
        ms-python.python \
        vector-of-bool.cmake-tools \
        twxs.cmake \
        formulahendry.terminal; \
        do \
            code --install-extension $ext; \
        done' && \
    echo 'export OMP_NUM_THREADS=$(nproc)' >> $DOCKER_HOME/.profile

USER root
