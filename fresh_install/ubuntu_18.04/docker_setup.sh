# This script automates the basic installation of docker-ce (stable) on Ubuntu 18.04
# It follows the steps on the official documentation at https://docs.docker.com/install/linux/docker-ce/ubuntu/
# Created on 18/2/2020 check link to see if instructions have changed.

echo "\e[1;36m -----------------------------------------------"
echo "Step 1: Removing older versions"
echo "----------------------------------------------- \e[0m"

wait(2)

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

echo "\e[1;36m -----------------------------------------------"
echo "Step 2: Installing Dependencies"
echo "----------------------------------------------- \e[0m"
wait(2)

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo "\e[1;36m -----------------------------------------------"
echo "Step 3: Adding official GPG key"
echo "----------------------------------------------- \e[0m"

wait(2)

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "\e[1;36m -----------------------------------------------"
echo "Step 4: Verifying fingerprint"
echo "----------------------------------------------- \e[0m"

wait(2)

sudo apt-key fingerprint 0EBFCD88

echo "\e[1;36m -----------------------------------------------"
echo "Step 5: Adding stable repository"
echo "----------------------------------------------- \e[0m"

wait(2)

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "\e[1;36m -----------------------------------------------"
echo "Step 6: Installing Docker enging - community"
echo "----------------------------------------------- \e[0m"

wait(2)

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "\e[1;36m -----------------------------------------------"
echo "Step 7: Verifying Docker Installation (Should see hello-world image)"
echo "----------------------------------------------- \e[0m"

wait(2)

sudo docker run hello-world

echo "\e[1;36m -----------------------------------------------"
echo "Step 8: Post Installation steps (Allows non-root to run docker without sudo)"
echo "----------------------------------------------- \e[0m"

wait(2)

sudo groupadd docker

sudo usermod -aG docker $USER

echo "\e[1;36m -----------------------------------------------"
echo "Complete, you need to log out and in for all post-installation changes to take effect"
echo "----------------------------------------------- \e[0m"

# EOF



