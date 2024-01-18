#!/bin/bash

# Mettre à jour les paquets
sudo apt-get update
sudo apt-get upgrade -y

# Installer des paquets utiles pour Ubuntu
sudo apt-get install -y ubuntu-restricted-extras build-essential curl git htop python3-pip vim nano tree

# Installer des paquets utiles pour le développement et les bibliothèques
sudo apt-get install -y build-essential curl git htop python3-pip python3-dev python3-venv libssl-dev libffi-dev zlib1g-dev \
libxml2-dev libxslt1-dev libjpeg-dev libpq-dev libmysqlclient-dev libsqlite3-dev libfreetype6-dev libblas-dev liblapack-dev \
libatlas-base-dev libhdf5-dev libopenblas-dev liblapacke-dev libboost-all-dev libcurl4-openssl-dev libgtk-3-dev libglfw3-dev \
libglfw3 libgl1-mesa-dev libglu1-mesa-dev libzmq3-dev libtbb-dev libtiff-dev libjpeg-turbo8-dev libpng-dev libavcodec-dev \
libavformat-dev libswscale-dev libv4l-dev libx264-dev libxvidcore-dev libcanberra-gtk-module libcanberra-gtk3-module libsm6 \
libxext6 libxrender-dev build-essential git ruby ruby-dev libpcap-dev libpq-dev zlib1g-dev libffi-dev libgmp-dev

# Installer Python 3 et pip
sudo apt-get install -y python3 python3-pip

# Installer Visual Studio Code
sudo snap install --classic code

# Installer Node.js et npm
sudo apt-get install -y nodejs npm

# Installer Java (OpenJDK)
sudo apt-get install -y default-jdk

# Installer VirtualBox
sudo apt-get install -y virtualbox

# Installer Discord
sudo snap install discord

# Installer Telegram
sudo snap install telegram-desktop

# Installer Remmina
sudo apt-get install -y remmina

# Nettoyage final
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "Installation terminée !"
