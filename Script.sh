#!/bin/bash

# ================================================================
# Script to install a wide range of cybersecurity tools on Ubuntu
# ================================================================

echo "Starting package update and installation..."

# Update system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install essential packages for Ubuntu and development libraries
sudo apt-get install -y curl git htop python3-pip vim nano tree \
python3-dev python3-venv libssl-dev libffi-dev zlib1g-dev \
libpcap-dev libpq-dev libsqlite3-dev libcurl4-openssl-dev \
build-essential ruby ruby-dev autoconf bison libpcap-dev \
libreadline-dev libxml2-dev locate ncurses-dev openssl \
postgresql postgresql-contrib wget xsel fuse

# Install some useful non-security tools for productivity
sudo snap install --classic code
sudo snap install discord telegram-desktop
sudo apt-get install -y remmina

# Install Node.js, npm, Java (OpenJDK), and VirtualBox
sudo apt-get install -y nodejs npm default-jdk virtualbox

# Install common security tools
echo "Installing common security tools..."

# Install penetration testing tools
sudo apt-get install -y nmap wireshark john hydra sqlmap aircrack-ng snort fail2ban tcpdump nbtscan onesixtyone nikto hashcat netdiscover

# Install additional tools for web application testing and exploitation
sudo apt-get install -y burpsuite recon-ng dirbuster gobuster theharvester wpscan whatweb

# Install reverse engineering and malware analysis tools
sudo apt-get install -y radare2 ghidra volatility

# Install for wireless penetration testing
sudo apt-get install -y reaver pixiewps

# Install Docker for containerized environments and testing
sudo apt-get install -y docker.io docker-compose

# Install Metasploit Framework
echo "Installing Metasploit Framework..."

cd ~
if [ ! -f msfinstall ]; then
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    chmod 755 msfinstall
    ./msfinstall
    echo "Metasploit installation completed."
else
    echo "Metasploit installation script is already present."
fi

# Install additional specialized tools
echo "Installing specialized cybersecurity tools..."

# Web application vulnerability scanners
sudo apt-get install -y nikto wpscan gobuster

# Exploit development and testing tools
sudo apt-get install -y exploitdb patator

# Other penetration testing tools
sudo apt-get install -y zaproxy ettercap-ng hydra

# Install Burp Suite (community edition)
echo "Installing Burp Suite..."
sudo snap install burp-suite

# Install the latest version of Kali Linux tools using Kali repositories (optional)
echo "Installing additional Kali tools..."

echo "Installing Kali Linux tools package..."
sudo apt install -y kali-linux-all

# Clean up any unnecessary packages
echo "Cleaning up system..."

sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "Cybersecurity tools installation completed."
