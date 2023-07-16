# 1. Check if Backport repository exists
if cat /etc/apt/sources.list | grep "backport" ;
then
  echo "Backport repo is present, skip adding"
else
  echo "deb http://archive.ubuntu.com/ubuntu ${version}-backports main restricted universe multiverse" |\
  sudo tee -a /etc/apt/sources.list
fi

# 2. Update the package manager
sudo apt-get update -y

# 3. Flush DNS cache
sudo resolvectl flush-caches

# 4. Install and run Apache2
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2

# 5. Install relevant Python version
sudo apt-get install -y python3

# 6. Install and run SSH-server
sudo apt-get install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# 7. Get the system name and version
distro=$(lsb_release -i 2> /dev/null | awk '{print $3}')
version=$(lsb_release -r 2> /dev/null | awk '{print $2}')
if ! [ -z $distro ] ;
then
  echo "OS Name: $distro"
  echo "OS Version: $version"
fi

# 8. Check if APT is installed
if [ -z $(command -v apt-get) ] ;
then
  echo "APT package manager is not installed in the system"
  echo "You probably run it on something other than Ubuntu"
  exit
fi
