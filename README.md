# Yiimp_install_scrypt v2.3.8 final tests on x64 (update Desember, 2025)
***********************************

## Install script for yiimp on Ubuntu Server 22.04/24.04 Deb12 x64 (for test final)
## Forked : https://github.com/vaudois/yiimp_install_scrypt ##
USE THIS SCRIPT ON FRESH INSTALL UBUNTU Server 22.04/24.04 Deb12 x64 !

Connect on your VPS =>
- adduser pool
- adduser pool sudo
- sudo su - pool
- sudo apt -y install git
- git clone https://github.com/Zuz99/yiimp_install_scrypt.git
- cd yiimp_install_scrypt/
- bash install.sh (DO NOT RUN THE SCRIPT AS ROOT or SUDO)
- At the end, you MUST REBOOT to finalize installation...

Finish !
Go http://xxx.xxx.xxx.xxx or https://xxx.xxx.xxx.xxx (if you have chosen LetsEncrypt SSL). Enjoy !

###### :bangbang: **YOU MUST UPDATE THE FOLLOWING FILES :**
- **/var/web/serverconfig.php :** update this file to include your public ip (line = YAAMP_ADMIN_IP) to access the admin panel (Put your PERSONNAL IP, NOT IP of your VPS). update with public keys from exchanges. update with other information specific to your server..
- **/etc/yiimp/keys.php :** update with secrect keys from the exchanges (not mandatory)


###### :bangbang: **IMPORTANT** : 

- The configuration of yiimp and coin require a minimum of knowledge in linux
- Your mysql information (login/Password) is saved in **~/.my.cnf**

***********************************

###### This script has an interactive beginning and will ask for the following information :

- Server Name 
- Are you using a subdomain
- Enter support email
- Enter Admin User
- Enter Password Admin
- Set stratum to AutoExchange
- Select Yimmp install
- Your Public IP for admin access (Put your PERSONNAL IP, NOT IP of your VPS)
- Install Fail2ban
- Install UFW and configure ports
- Install LetsEncrypt SSL

***********************************

**This install script will get you 95% ready to go with yiimp. There are a few things you need to do after the main install is finished.**

While I did add some server security to the script, it is every server owners responsibility to fully secure their own servers. After the installation you will still need to customize your serverconfig.php file to your liking, add your API keys, and build/add your coins to the control panel. 

There will be several wallets already in yiimp. These have nothing to do with the installation script and are from the database import from the yiimp github. 


## Dont use this scirpt.. This source work in progres ##
