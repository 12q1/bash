clear
echo '------------------------------------------------------'
echo -e '\e[1;36m Starting setup script... \e[0m'
echo '------------------------------------------------------'

sudo apt-get update && sudo apt-get upgrade -y

echo '------------------------------------------------------'
echo -e '\e[1;36m Adding non-default Debian repositories... \e[0m'
echo '------------------------------------------------------'

sudo apt-add-repository non-free
sudo apt-add-repository contrib

echo '------------------------------------------------------'
echo -e '\e[1;36m Preparing 32-bit architecture (for linux steam)... \e[0m'
echo '------------------------------------------------------'

sudo dpkg --add-architecture i386
sudo apt update

echo '------------------------------------------------------'
echo -e '\e[1;36m Adding media codecs... \e[0m'
echo '------------------------------------------------------'

sudo apt install libavcodec-extra -y

echo '------------------------------------------------------'
echo -e '\e[1;36m Installing basic applications... \e[0m'
echo '------------------------------------------------------'

echo -e '\e[1;34m -asciinema \e[0m'
sudo apt install asciinema -y
echo -e '\e[1;34m -calibre \e[0m'
sudo apt install calibre -y
echo -e '\e[1;34m -chromium \e[0m'
sudo apt install chromium -y
echo -e '\e[1;34m -curl \e[0m'
sudo apt install curl -y
echo -e '\e[1;34m -discord \e[0m'
sudo apt install discord -y
#echo -e '\e[1;34m -docker-ce \e[0m'
#sudo apt install docker-ce -y
echo -e '\e[1;34m -filezilla \e[0m'
sudo apt install filezilla -y
echo -e '\e[1;34m -fonts-powerline \e[0m'
sudo apt install fonts-powerline -y
echo -e '\e[1;34m -gimp \e[0m'
sudo apt install gimp -y
echo -e '\e[1;34m -git \e[0m'
sudo apt install git -y
echo -e '\e[1;34m -gnome-tweak-tool \e[0m'
sudo apt install gnome-tweak-tool -y
echo -e '\e[1;34m -htop \e[0m'
sudo apt install htop -y
echo -e '\e[1;34m -httpie \e[0m'
sudo apt install httpie -y
echo -e '\e[1;34m -lm-sensors \e[0m'
sudo apt install lm-sensors -y
echo -e '\e[1;34m -npm \e[0m'
sudo apt install npm -y
echo -e '\e[1;34m -nmap \e[0m'
sudo apt install nmap -y
echo -e '\e[1;34m -qbittorrent \e[0m'
sudo apt install qbittorrent -y
echo -e '\e[1;34m -ranger \e[0m'
sudo apt install ranger -y
echo -e '\e[1;34m -rar \e[0m'
sudo apt install rar -y
echo -e '\e[1;34m -steam \e[0m'
sudo apt install steam -y
echo -e '\e[1;34m -speedtest-cli \e[0m'
sudo apt install speedtest-cli -y
echo -e '\e[1;34m -terminator \e[0m'
sudo apt install terminator -y
echo -e '\e[1;34m -timeshift \e[0m'
sudo apt install timeshift -y
echo -e '\e[1;34m -tldr \e[0m'
sudo apt install tldr -y
echo -e '\e[1;34m -tlp \e[0m'
sudo apt install tlp -y
echo -e '\e[1;34m -tmux \e[0m'
sudo apt install tmux -y
echo -e '\e[1;34m -trash-cli \e[0m'
sudo apt install trash-cli -y
echo -e '\e[1;34m -vlc \e[0m'
sudo apt install vlc -y
echo -e '\e[1;34m -wireshark \e[0m'
sudo apt install wireshark -y
echo -e '\e[1;34m -wget \e[0m'
sudo apt install wget -y
#echo -e '\e[1;34m -yarn \e[0m'
#sudo apt install yarn -y
echo -e '\e[1;34m -youtube-dl \e[0m'
sudo apt install youtube-dl -y
echo -e '\e[1;34m -zenmap \e[0m'
sudo apt install zenmap -y

echo '------------------------------------------------------'
echo -e '\e[1;36m Performing final cleanup... \e[0m'
echo '------------------------------------------------------'
sudo apt update && sudo apt upgrade -y
##remove unused packages
sudo apt autoremove -y
##cleans and clear apt cache
sudo apt autoclean -y
sudo apt clean

echo '------------------------------------------------------'
echo -e '\e[1;36m System Info \e[0m'
echo '------------------------------------------------------'
uname -a

echo '------------------------------------------------------'
echo -e '\e[1;36m System Sensors \e[0m'
echo '------------------------------------------------------'
sudo sensors-detect -y
sensors

echo '------------------------------------------------------'
echo "Don't forget chrome, vscode, discord, nordvpn, nvm, yarn, postman, docker-ce!!!"
echo '------------------------------------------------------'

echo 'Done'
