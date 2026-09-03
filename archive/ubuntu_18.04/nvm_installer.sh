#This script simply automates the installation of nvm
#requires curl to function

echo "-----------------------------------------------"
echo -e "\e[1;36m Installing nvm, make sure curl is already installed \e[0m"
echo "-----------------------------------------------"

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash


echo "-----------------------------------------------"
echo -e "\e[1;36m Resetting bashrc \e[0m"
echo "-----------------------------------------------"

source ~/.bashrc

echo "-----------------------------------------------"
echo -e "\e[1;36m Listing available versions of Node.js \e[0m"
echo "-----------------------------------------------"

nvm ls-remote

echo "-----------------------------------------------"
echo -e "\e[1;36m Use 'nvm install vXX.XX.X' to install desired version \e[0m"
echo "-----------------------------------------------"

# EOF