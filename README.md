# Docker Image for AMS 595
This Docker image provides a Ubuntu 16.04 environment for the class
"AMS 595: Fundamental of Computing" at Stony Brook University.
The course covers Octave, Python, and C++. This environment provides
preinstalled Octave 4.0.2, Python 3.5.2 (with NumPy, SciPy, Pandas and Spyder),
gcc 5.4.0, Jupyter Notebook with Octave and Python kernels, Atom, and ddd.
The image runs the LXDE Windows Manager in Ubuntu, which will show in a
web browser, so that you can use the same environment regardless whether
you use Linux, Mac or Windows.

[![Build Status](https://travis-ci.org/compdatasci/docker-desktop.svg?branch=ams595)](https://travis-ci.org/compdatasci/docker-desktop) [![](https://images.microbadger.com/badges/image/ams595/desktop.svg)](https://microbadger.com/images/ams595/desktop)

## Preparation

You can use this Docker image on 64-bit Linux, Mac or Windows. Before you start,
please install Python and Docker on your computer.

### Installing Python
If you use Linux or Mac, chances are Python is already installed on your system,
so you can skip this step.

If you use Windows, you need to install Python if you have not yet done so.
You can download the Windows installer at
https://www.python.org/downloads/windows/.
You can choose either Python 3.x or Python 2.x. Note that you need to
add Python into the PATH. See
http://python-guide-pt-br.readthedocs.io/en/latest/starting/install/win/
for more detail. Alternatively, you can also install Anaconda, which contains
NumPy, SciPy, Spyder etc. and will set the path for you automatically.
You can download Anaconda at https://www.continuum.io/downloads#windows.

### Installing Docker

You can download Docker Community Edition for free at
https://www.docker.com/community-edition#/download.

Note for Windows users: Docker only supports 64-bit Windows 10 Pro or higher.
If you have Windows 8 or Windows 10 Home, you need to upgrade your
Windows operating system before installing Docker. Stony Brook Students can
get Windows 10 Education free of charge at https://stonybrook.onthehub.com.
The [Docker Toolbox](https://www.docker.com/products/docker-toolbox) supports
older versions of Windows, but we do not recommend it.

## Running the Desktop Environment

To run the desktop, start a terminal (or a PowerShell Prompt on Windows).
Change to the directory to a working directory where you will store the
source codes and data, and then run the command:
```
curl -L -s https://github.com/compdatasci/docker-desktop/raw/ams595/docker-desktop | python - -p
```
This will run the Docker image and then launch your default web browser and show
the desktop environment. The `-p` option above is optional, and it instructs
the Python script to pull the latest image each time.

You can also use the Docker image as a Jupyter-Notebook server for the
default web browser on your computer. Replace the above command with
```
curl -L -s https://github.com/compdatasci/docker-desktop/raw/ams595/docker-jupyter | python - -p
```
in the directory where the Jupyter notebooks are stored.
