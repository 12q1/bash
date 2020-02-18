# This script adds a number of apt packages that I like to use
# Created on 18/2/2020 

echo '------------------------------------------------------'
echo -e '\e[1;36m Initializing... \e[0m'
echo '------------------------------------------------------'

sudo apt-get update && sudo apt-get upgrade -y

echo '------------------------------------------------------'
echo -e '\e[1;36m Installing basic applications (Ubuntu 18.04) \e[0m'
echo '------------------------------------------------------'
sleep 2s

echo -e '\e[1;34m -asciinema \e[0m'
sudo apt install asciinema -y
# Record and share terminal sessions https://asciinema.org/

echo -e '\e[1;34m -calibre \e[0m'
sudo apt install calibre -y
# eBook reader/manager/converter https://calibre-ebook.com/

echo -e '\e[1;34m -curl \e[0m'
sudo apt install curl -y
# Command line tool to transfer data https://github.com/curl/curl

echo -e '\e[1;34m -filezilla \e[0m'
sudo apt install filezilla -y
# FTP client https://filezilla-project.org/

echo -e '\e[1;34m -fonts-powerline \e[0m'
sudo apt install fonts-powerline -y
# Font needed for Powerline statusline https://github.com/powerline/fonts

echo -e '\e[1;34m -gimp \e[0m'
sudo apt install gimp -y
# Image editing software https://www.gimp.org/

echo -e '\e[1;34m -git \e[0m'
sudo apt install git -y
# Version control system https://git-scm.com/

echo -e '\e[1;34m -gnome-tweak-tool \e[0m'
sudo apt install gnome-tweak-tool -y
# GNOME shell customization software https://gitlab.gnome.org/GNOME/gnome-tweaks

echo -e '\e[1;34m -htop \e[0m'
sudo apt install htop -y
# Process viewer https://hisham.hm/htop/

echo -e '\e[1;34m -httpie \e[0m'
sudo apt install httpie -y
# Command line HTTP client https://httpie.org/

echo -e '\e[1;34m -lm-sensors \e[0m'
sudo apt install lm-sensors -y
# Hardware monitoring tool https://github.com/lm-sensors/lm-sensors

echo -e '\e[1;34m -nmap \e[0m'
sudo apt install nmap -y
# Networking mapping and auditing tool https://nmap.org/

echo -e '\e[1;34m -qbittorrent \e[0m'
sudo apt install qbittorrent -y
# Bittorrent client https://www.qbittorrent.org/

echo -e '\e[1;34m -ranger \e[0m'
sudo apt install ranger -y
# Command line file explorer https://github.com/ranger/ranger

echo -e '\e[1;34m -rar \e[0m'
sudo apt install rar -y
# Tool to create rar files

echo -e '\e[1;34m -steam \e[0m'
sudo apt install steam -y
# Steam client for games https://store.steampowered.com/about/

echo -e '\e[1;34m -speedtest-cli \e[0m'
sudo apt install speedtest-cli -y
# Command line tool to test network speed https://www.speedtest.net/

echo -e '\e[1;34m -terminator \e[0m'
sudo apt install terminator -y
# Terminal emulator https://gnometerminator.blogspot.com/p/introduction.html

echo -e '\e[1;34m -timeshift \e[0m'
sudo apt install timeshift -y
# System backup tool https://github.com/teejee2008/timeshift

echo -e '\e[1;34m -tldr \e[0m'
sudo apt install tldr -y
# Tool to condense man pages

echo -e '\e[1;34m -tlp \e[0m'
sudo apt install tlp -y
# Tool to handle power usage (useful for laptops) https://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html

echo -e '\e[1;34m -tmux \e[0m'
sudo apt install tmux -y
# Terminal multiplexer with shared session capability https://github.com/tmux/tmux

echo -e '\e[1;34m -trash-cli \e[0m'
sudo apt install trash-cli -y
# Command line tool for trashing files instead of rm https://github.com/sindresorhus/trash-cli

echo -e '\e[1;34m -ubuntu-restricted-extras \e[0m'
sudo apt install ubuntu-restricted-extras -y
# Adding extra media codecs

echo -e '\e[1;34m -unrar \e[0m'
sudo apt install unrar -y
# Tool to unpack rar files

echo -e '\e[1;34m -vlc \e[0m'
sudo apt install vlc -y
# Media player https://www.videolan.org/vlc/index.html

echo -e '\e[1;34m -wireshark \e[0m'
sudo apt install wireshark -y
# Network monitoring tool https://www.wireshark.org/

echo -e '\e[1;34m -wget \e[0m'
sudo apt install wget -y
# Command line tool to transfer data https://www.gnu.org/software/wget/

echo -e '\e[1;34m -youtube-dl \e[0m'
sudo apt install youtube-dl -y
# Stream downloader https://youtube-dl.org/

echo -e '\e[1;34m -zenmap \e[0m'
sudo apt install zenmap -y
# GUI interface for nmap https://nmap.org/zenmap/

echo '------------------------------------------------------'
echo -e '\e[1;36m Performing final cleanup... \e[0m'
echo '------------------------------------------------------'
sleep 2s

sudo apt update && sudo apt upgrade -y

# removes amazon bloatware
sudo apt purge ubuntu-web-launchers -y

# removes packages that failed to install
sudo apt autoclean -y

# removes the apt-cache
sudo apt clean

# remove unused dependencies
sudo apt autoremove -y

echo '------------------------------------------------------'
echo -e '\e[1;36m System Info \e[0m'
echo '------------------------------------------------------'
uname -a

echo '------------------------------------------------------'
echo -e "\e[1;36m  Install chrome, vscode, discord, nordvpn, nvm, yarn, postman, docker-ce separately \e[0m"
echo '------------------------------------------------------'

