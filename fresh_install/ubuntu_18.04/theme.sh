# This script contains ppas, apt installs, and configurations involved with theming
# Running this script multiple times will mess up your .bashrc file, take care
# Last update 19/2/2020

echo "-----------------------------------------------"
echo -e "\e[1;36m Installing packages \e[0m"
echo "-----------------------------------------------"

echo -e '\e[1;34m -fonts-powerline \e[0m'
sudo apt install fonts-powerline -y

echo -e '\e[1;34m -gnome-shell-extensions \e[0m'
sudo apt install gnome-shell-extensions -y
#enables gnome-tweak-tools to change shell theme

echo -e '\e[1;34m -papirus-icon-theme \e[0m'
sudo apt install papirus-icon-theme -y

echo -e '\e[1;34m -materia-gtk-theme \e[0m'
sudo apt install materia-gtk-theme -y

echo -e '\e[1;34m -python-setuptools \e[0m'
sudo apt-get install python-setuptools
#dependency needed to install powerline-shell

echo "-----------------------------------------------"
echo -e "\e[1;36m Installing powerline-shell \e[0m"
echo "-----------------------------------------------"
cd ~/Documents
mkdir powerline_shell_stuff
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
sudo apt remove gnome-shell-extension-ubuntu-dock
#This segment removes the ubuntu default dock

echo "-----------------------------------------------"
echo -e "\e[1;36m Choose css file\e[0m"
echo "-----------------------------------------------"
sudo update-alternatives --config gdm3.css
#Pick .../theme/gnome-shell.css for default gnome appearance

echo "-----------------------------------------------"
echo -e "\e[1;36m Done \e[0m"
echo "-----------------------------------------------"

cd ~
source .bashrc

# EOF