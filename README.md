# UbuntuCommonTools

A Bash script that automates the setup of a fresh Ubuntu system for software development and penetration testing. Designed to get you from a clean install to a fully operational environment in one shot.

## Features

- **System** — Full apt upgrade, core build dependencies, Python 3, pipx, Go, Java (OpenJDK), Node.js LTS
- **Docker** — Official Docker CE repo, compose plugin, automatic group + socket permission fix (no logout required)
- **Network & Recon** — Nmap, tcpdump, Wireshark (with non-root capture permissions), netdiscover, masscan
- **Pentest tools** — Hydra, SQLMap, John, Hashcat, Aircrack-ng, Nikto, ExploitDB, Radare2, Metasploit
- **Web** — Gobuster, httpx (via Go)
- **Shell** — Zsh + Oh My Zsh with autosuggestions, syntax highlighting, and fzf
- **Apps** — Visual Studio Code, Discord, Telegram

## Usage

```bash
git clone https://github.com/Vasco0x4/UbuntuCommonTools.git
cd UbuntuCommonTools
chmod +x setup.sh
./setup.sh
```

## Post-install

```bash
# Apply group changes without rebooting
newgrp docker && newgrp wireshark

# httpx
~/go/bin/httpx

# Reload shell with plugins
source ~/.zshrc
```

## Requirements

- Ubuntu 24.04 / 26.04 LTS
- sudo privileges
