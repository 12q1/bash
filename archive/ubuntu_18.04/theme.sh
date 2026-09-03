# This script contains ppas, apt installs, and configurations involved with theming
# Running this script multiple times may mess up your .bashrc file, take care and make a backup
# Last update 19/2/2020

echo '------------------------------------------------------'
echo -e '\e[1;36m Initializing... \e[0m'
echo '------------------------------------------------------'

sudo apt-get update && sudo apt-get upgrade -y

echo "-----------------------------------------------"
echo -e "\e[1;36m Installing packages \e[0m"
echo "-----------------------------------------------"

echo -e '\e[1;34m -fonts-powerline \e[0m'
sudo apt install fonts-powerline -y

echo -e '\e[1;34m -gnome-shell-extensions \e[0m'
sudo apt install gnome-shell-extensions -y
# enables gnome-tweak-tools to change shell theme

echo -e '\e[1;34m -papirus-icon-theme \e[0m'
sudo apt install papirus-icon-theme -y

echo -e '\e[1;34m -materia-gtk-theme \e[0m'
sudo apt install materia-gtk-theme -y

echo -e '\e[1;34m -python-setuptools \e[0m'
sudo apt install python-setuptools -y
# dependency needed to install powerline-shell

echo -e '\e[1;34m -gnome-session \e[0m'
sudo apt install gnome-session -y

echo -e '\e[1;34m -vanilla-gnome-desktop \e[0m'
sudo apt install vanilla-gnome-desktop -y
# installs vanilla gnome settings

echo -e '\e[1;34m -gnome-shell-extension-system-monitor \e[0m'
sudo apt install gnome-shell-extension-system-monitor -y
# installs system monitor in top bar

echo "-----------------------------------------------"
echo -e "\e[1;36m Installing powerline-shell \e[0m"
echo "-----------------------------------------------"
cd ~/Documents
mkdir powerline_shell_stuff
cd powerline_shell_stuff
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
sudo python setup.py install

echo '#--------Start of Powerline script----------' >> ~/.bashrc
echo "function _update_ps1() { 
    PS1=\$(powerline-shell \$?) 
} 
if [[ \$TERM != linux && ! \$PROMPT_COMMAND =~ _update_ps1 ]]; then 
    PROMPT_COMMAND=\"_update_ps1; \$PROMPT_COMMAND\" 
fi" >> ~/.bashrc
echo '#---------End of Powerline script-----------' >> ~/.bashrc

echo "-----------------------------------------------"
echo -e "\e[1;36m Removing Ubuntu-dock \e[0m"
echo "-----------------------------------------------"
sudo apt remove gnome-shell-extension-ubuntu-dock -y
#This segment removes the ubuntu default dock

echo "-----------------------------------------------"
echo -e "\e[1;36m Choose css file\e[0m"
echo "-----------------------------------------------"
sudo update-alternatives --config gdm3.css
#Pick .../theme/gnome-shell.css for default gnome appearance

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

echo "-----------------------------------------------"
echo -e "\e[1;36m Done, log out to apply all settings \e[0m"
echo "-----------------------------------------------"

cd ~
source .bashrc

# EOF