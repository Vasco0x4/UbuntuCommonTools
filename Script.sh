#!/bin/bash
# ================================================================
# Cybersecurity tools install script - Ubuntu 26.04 LTS
# ================================================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

apt_try() {
  for pkg in "$@"; do
    if apt-cache show "$pkg" &>/dev/null; then
      sudo apt-get install -y "$pkg"
    else
      warn "Not found in apt, skipping: $pkg"
    fi
  done
}

# ── System update ────────────────────────────────────────────────
log "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

# ── Core dependencies ────────────────────────────────────────────
log "Installing core dependencies..."
sudo apt-get install -y \
  curl git htop nano tree wget fuse xsel gpg \
  python3-dev python3-venv pipx \
  libssl-dev libffi-dev zlib1g-dev libpcap-dev libpq-dev \
  libsqlite3-dev libcurl4-openssl-dev libreadline-dev \
  libxml2-dev libncurses-dev \
  build-essential autoconf bison openssl \
  postgresql postgresql-contrib \
  default-jdk golang-go locate \
  zsh ca-certificates gnupg

# ── Node.js LTS ──────────────────────────────────────────────────
log "Installing Node.js LTS..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# ── Docker (official repo) ───────────────────────────────────────
log "Installing Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Fix Docker permissions (avoid "permission denied" on docker socket)
sudo usermod -aG docker "$USER"
sudo chmod 666 /var/run/docker.sock

# ── Network & recon ───────────────────────────────────────────────
log "Installing network tools..."
apt_try nmap tcpdump wireshark netdiscover masscan

# Fix Wireshark permissions (avoid CAP_NET_RAW error)
echo "wireshark-common wireshark-common/install-setuid boolean true" | \
  sudo debconf-set-selections
sudo dpkg-reconfigure -f noninteractive wireshark-common
sudo usermod -aG wireshark "$USER"

# ── Pentest tools ─────────────────────────────────────────────────
log "Installing pentest tools..."
apt_try hydra sqlmap john hashcat aircrack-ng \
        nikto exploitdb fail2ban snort \
        remmina radare2

# ── Web ───────────────────────────────────────────────────────────
log "Installing web tools..."
apt_try gobuster

log "Installing httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest || \
  warn "httpx failed — check go installation"

# ── Metasploit ────────────────────────────────────────────────────
log "Installing Metasploit..."
curl -s https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb \
  -o /tmp/msfinstall
chmod 755 /tmp/msfinstall && /tmp/msfinstall || warn "Metasploit install failed, skip"

# ── Zsh + Oh My Zsh ───────────────────────────────────────────────
log "Installing Zsh + Oh My Zsh..."
sudo apt-get install -y zsh

# Set zsh as default shell
chsh -s "$(which zsh)" "$USER"

# Install Oh My Zsh (unattended)
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# fzf (non-interactive)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Enable plugins in .zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)/' ~/.zshrc

# ── Snaps ─────────────────────────────────────────────────────────
log "Installing snaps..."
sudo snap install --classic code
sudo snap install discord telegram-desktop

# ── Cleanup ───────────────────────────────────────────────────────
log "Cleaning up..."
sudo apt-get autoremove -y && sudo apt-get autoclean -y
sudo updatedb

echo ""
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}  Done!${NC}"
echo -e "${GREEN}================================================================${NC}"
echo ""
echo "  → Logout/login requis pour appliquer les groupes (docker, wireshark)"
echo "  → Ou lance: newgrp docker && newgrp wireshark"
echo "  → httpx dispo via: ~/go/bin/httpx"
echo "  → Lance 'zsh' si le shell n'a pas changé automatiquement"
