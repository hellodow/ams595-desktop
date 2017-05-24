# Docker Image for AMS 595
This Docker image provides the Ubuntu 16.04 environment with X Windows for the class
"AMS 595: Fundamental of Computing" at Stony Brook University.
The course covers programming using MATLAB/Octave, Python, and C++. This image runs the lightweight LXDE Windows Manager, and has Octave 4.0.2, Python 3.5.2 (with NumPy, SciPy, Pandas and Spyder),
gcc 5.4.0, Jupyter Notebook with Octave and Python kernels, Atom, and ddd preinstalled. The X Windows will display in your web browser in full-screen mode. You can use this Docker image on 64-bit Linux, Mac or Windows. It allows you to use the same programming environment regardless which OS you are running on your laptop or desktop.

<img src="https://raw.github.com/compdatasci/docker-desktop/ams595/screenshots/screenshot1.png" width=1024/>

[![Build Status](https://travis-ci.org/compdatasci/docker-desktop.svg?branch=ams595)](https://travis-ci.org/compdatasci/docker-desktop) [![](https://images.microbadger.com/badges/image/ams595/desktop.svg)](https://microbadger.com/images/ams595/desktop)

## Preparation
Before you start, you need to first install Python and Docker on your computer by following the steps below.

### Installing Python
If you use Linux or Mac, Python is most likely already installed on your computer, so you can skip this step.

If you use Windows, you need to install Python if you have not yet done so. The easiest way is to install `Miniconda`, which you can download at https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe. You can use the default options during installation.

### Installing Docker
You can download the Docker Community Edition for free at https://www.docker.com/community-edition#/download. After installation, make sure you launch Docker before proceeding to the next step.

**Notes for Windows Users**
1. Docker only supports 64-bit Windows 10 Pro or higher. If you have Windows 8 or Windows 10 Home, you need to upgrade your Windows operating system before installing Docker. Stony Brook students can get Windows 10 Education free of charge at https://stonybrook.onthehub.com. Note that the older [Docker Toolbox](https://www.docker.com/products/docker-toolbox) supports older versions of Windows, but it should not be used.
2. When you use Docker for the first time, you must change its settings to make the C drive shared. To do this, right-click the Docker icon in the system tray, and then click on `Settings...`. Go to `Shared Drives` tab and check the C drive.

## Running the Docker Image

### Running the Docker Image on Windows
To run the docker image, start `Windows PowerShell` on Windows. Using the `cd` command to change to the working directory where you will store your codes and data. Then run the following two commands:
```
curl https://raw.githubusercontent.com/compdatasci/docker-desktop/ams595/docker-desktop -outfile docker-desktop
python docker-desktop -p
```
This will download and run the Docker image and then launch your default web browser to show the desktop environment. The `-p` option above is optional, and it instructs the Python script to pull and update the image to the latest version.

### Running the Docker Image on Linux or Mac
To run the docker image, start a terminal. Using the `cd` command to change to the working directory where you will store your codes and data, and then run the command:
```
curl -s https://raw.githubusercontent.com/compdatasci/docker-desktop/ams595/docker-desktop | python - -p
```
This will download and run the Docker image and then launch your default web browser to show the desktop environment. The `-p` option above is optional, and it instructs the Python script to pull and update the image to the latest version.

### Running the Docker Image as Jupyter-Notebook Server
Besides using the Docker Image as an X-Windows desktop environment, you can also use it as a Jupyter-Notebook server with the
default web browser on your computer. Simply replace `docker-desktop` with `docker-jupyter` in the preceding commands. That is, on Windows run the commands
```
curl https://raw.githubusercontent.com/compdatasci/docker-desktop/ams595/docker-jupyter -outfile docker-desktop
python docker-jupyter -p
```
or on Linux and Mac run the command
```
curl -s https://raw.githubusercontent.com/compdatasci/docker-desktop/ams595/docker-jupyter | python - -p
```
in the PowerShell or terminal prompt, in the directory where your Jupyter notebooks are stored.

### Stopping the Docker Image
To stop the Docker image, press Ctrl-C twice in the terminal (or Windows PowerShell on Windows) on your host computer where you started the Docker image, and close the tab for the desktop in your web browser.

## Tips
1. When using the Docker image, only the files under $HOME/shared and $HOME/.config are persistent. The former maps to the working directory on your host where you started the docker image, and the latter contains the configuration files of the desktop environment. Any change to the files in other directories will be lost when you stop the Docker image. Make sure you save all your source codes in the $HOME/shared.
2. After you start the Docker image, change your web browser to full-screen mode, and then the desktop environment will then run in full screen. To exit full-screen mode, use the command specific to your web browser (typically F11 or Fn-F11 on Windows or Linux, and Ctrl-Meta-F on Mac).
3. By default, Docker uses two CPU cores and 2GB of memory for its images. This is sufficient for doing homework for this class. If you want to run large jobs, go to the `Advanced` tab in `Settings` (or `Preferences` for Mac) and increase the amount of memory dedicated to Docker.
4. You can copy and paste between the host and the Docker image through the "Clipboard" box in the left toolbar, which is synced automatically with the clipboard of the Docker image. To copy from the Docker image to the host, first select the text in the Docker image, and then go to this "Clipboard" box to copy.
To copy from host to the Docker image, first paste the text into this Clipboard box, and then paste the text in the Docker image.
