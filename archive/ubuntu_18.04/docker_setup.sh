# This script automates the basic installation of docker-ce (stable) on Ubuntu 18.04
# It follows the steps on the official documentation at https://docs.docker.com/install/linux/docker-ce/ubuntu/
# Created on 18/2/2020 check link to see if instructions have changed.

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 1: Removing older versions \e[0m"
echo "-----------------------------------------------"

sleep 2s

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 2: Installing Dependencies \e[0m"
echo "-----------------------------------------------"
sleep 2s

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 3: Adding official GPG key \e[0m"
echo "-----------------------------------------------"

sleep 2s

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 4: Verifying fingerprint \e[0m"
echo "-----------------------------------------------"

sleep 2s

sudo apt-key fingerprint 0EBFCD88

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 5: Adding stable repository \e[0m"
echo "-----------------------------------------------"

sleep 2s

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 6: Installing Docker enging - community \e[0m"
echo "-----------------------------------------------"

sleep 2s

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 7: Verifying Docker Installation (Should see hello-world image) \e[0m"
echo "-----------------------------------------------"

sleep 2s

sudo docker run hello-world

echo "-----------------------------------------------"
echo -e "\e[1;36m Step 8: Post Installation steps \e[0m"
echo "-----------------------------------------------"
#remove this step if security is a concern
#it allows non-root users to run docker

sleep 2s

sudo groupadd docker

sudo usermod -aG docker $USER

echo "-----------------------------------------------"
echo -e "\e[1;36m Complete, you need to log out and in for all post-installation changes to take effect \e[0m"
echo "-----------------------------------------------"

# EOF



