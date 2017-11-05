#!/bin/bash
 
: <<'END'
    This script is for testing purposes only
 
    This script aims to setup almost everything for the TFS server on a Debian based OS.
    The only thing you will need to do yourself is the configuration of the mysql, phpmyadmin and your config.lua as well as any dat or spr you may need.
 
    The project directory which is created, is placed in your home directory and then each aspect of the server is then placed in its own folder keeping everything nice and clean. All 3 executables are copied to their base directories after they have been compiled.
 
    To install this script, open a terminal in the same directory as this file, key combo to open a terminal is
    ctrl + alt + t
    Type in the terminal
    chmod +x otsetup.sh
    If you named the file something else then you need to type that name in, if there are spaces in the name you need to use single quotes e.g. 'this is the file i named it as.sh'
    If you are unsure of the spelling then type
    ls
    or
    ls -a
    which will list everything even hidden files
 
    Type in the terminal
    ./otsetup.sh
    This will execute script.
END
 
# Name of the Project, if there is a space in the name use either an _ or a - in its place
TFS='TFS'
 
# Go to the Home directory and make a Project directory
cd ~
mkdir $TFS && cd $TFS
 
# TFS - Server
sudo apt-get install -y git cmake build-essential liblua5.2-dev libgmp3-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libpugixml-dev
 
# Go to the Project directory
cd ~/$TFS
 
# Git
git clone --recursive https://github.com/otland/forgottenserver.git
 
# Compile
cd forgottenserver && mkdir build && cd build && cmake .. && make
cp tfs ../
 
 
# RME
sudo apt-get install -y git cmake libboost-system-dev libboost-thread-dev libglu1-mesa-dev libwxgtk3.0-dev libarchive-dev freeglut3-dev libxmu-dev libxi-dev
 
# Go to the Project directory
cd ~/$TFS
 
# Git
git clone https://github.com/hjnilsson/rme.git
 
# Compile
mkdir rme/build && cd rme/build && cmake .. && make
cp rme ../
 
 
# Otclient
sudo apt-get install -y build-essential cmake git-core libboost1.58-all-dev liblua5.1-0-dev libglew1.13 libvorbis-dev libopenal-dev libphysfs-dev libglewmx-dev libz3-dev freeglut3-dev libc6-dev-i386 doxygen libncurses5-dev mercurial libssl-dev
 
# Go to the Project directory
cd ~/$TFS
 
# PhysicsFS is a library to provide abstract access to various archives
hg clone -r stable-2.0 http://hg.icculus.org/icculus/physfs/
cd physfs
sudo mkdir build
cd build
sudo cmake ..
sudo make
sudo make install
sudo mv /usr/local/lib/libphysfs.a /usr/lib/x86_64-linux-gnu/.
 
# Go to the Project directory
cd ~/$TFS
 
# Get the sources, compile and run
git clone git://github.com/edubart/otclient.git
cd otclient && mkdir build && cd build && cmake .. && make
cp otclient ../
 
# Install Lamp -- You will need to be at the terminal to setup the password for Mysql
sudo apt-get install -y lamp-server^
 
# Install PhpMyadmin -- You will need to be at the terminal to confirm the password for Mysql
sudo apt-get install -y phpmyadmin
