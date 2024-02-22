#!/bin/bash

echo "Début de la mise à jour et de l'installation des paquets..."

# Mettre à jour les paquets
sudo apt-get update
sudo apt-get upgrade -y

# Installer des paquets utiles pour Ubuntu et des bibliothèques de développement
sudo apt-get install -y ubuntu-restricted-extras build-essential curl git htop python3-pip vim nano tree \
python3-dev python3-venv libssl-dev libffi-dev zlib1g-dev libxml2-dev libxslt1-dev libjpeg-dev libpq-dev \
libmysqlclient-dev libsqlite3-dev libfreetype6-dev libblas-dev liblapack-dev libatlas-base-dev libhdf5-dev \
libopenblas-dev liblapacke-dev libboost-all-dev libcurl4-openssl-dev libgtk-3-dev libglfw3-dev libglfw3 \
libgl1-mesa-dev libglu1-mesa-dev libzmq3-dev libtbb-dev libtiff-dev libjpeg-turbo8-dev libpng-dev libavcodec-dev \
libavformat-dev libswscale-dev libv4l-dev libx264-dev libxvidcore-dev libcanberra-gtk-module libcanberra-gtk3-module \
libsm6 libxext6 libxrender-dev build-essential git ruby ruby-dev libpcap-dev libpq-dev zlib1g-dev libffi-dev libgmp-dev \
curl gpgv2 autoconf bison git-core libapr1 libaprutil1 libgmp3-dev libpcap-dev libreadline6-dev libsqlite3-dev \
libsvn1 libtool libxml2 libyaml-dev locate ncurses-dev openssl postgresql postgresql-contrib wget xsel

# Installer Visual Studio Code, Discord, Telegram, et Remmina
sudo snap install --classic code
sudo snap install discord telegram-desktop
sudo apt-get install -y remmina

# Installer Node.js, npm, Java (OpenJDK), VirtualBox
sudo apt-get install -y nodejs npm default-jdk virtualbox

# Nettoyage final
sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo "Installation des outils de base terminée."

echo "Installation des outils de tests de pénétration..."
# Installer des outils de tests de pénétration
sudo apt-get install -y nmap wireshark john hydra sqlmap aircrack-ng snort fail2ban tcpdump netcat nbtscan onesixtyone nikto

# Installer Metasploit
cd ~
if [ ! -f msfinstall ]; then
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    chmod 755 msfinstall
    ./msfinstall
    echo "Installation de Metasploit terminée."
else
    echo "Le script d'installation de Metasploit est déjà présent."
fi
