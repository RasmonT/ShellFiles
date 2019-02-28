#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 
BLUE='\033[1;34m'
CYAN='\033[1;36m'

#Checking Server status
if ! /usr/local/bin/evos-cli getinfo >/dev/null 2>&1; then
    echo -e "${GREEN}I will start Evos server, then i check for Daemon version... ${NC}"
    evosd
    sleep 10s 
else
    echo -e "${GREEN} Server is running, i will check if version is correct! ${NC}"
    sleep 2s
    fi	
	
#Version Checking
/usr/local/bin/evos-cli --version
if [ "$(/usr/local/bin/evos-cli --version)" = "Evos Core RPC client version v1.1.3.0-2ba4298" ]; then
    echo -e "${GREEN} Version of Daemon is correct! ${NC}"
else
    echo -e "${YELLOW} Version of Daemon is Incorrect! ${NC}"
	sleep 1s
	echo -e "${YELLOW} I will force update of the daemon! ${NC}"
	sleep 1s
	echo -e "${GREEN} Stopping Evos Server and will update Daemon! ${NC}"
	evos-cli stop
    sleep 4s
    rm -rf .evos/mncache.dat .evos/mnpayments.dat .evos/peers.dat
    rm -rf /usr/local/bin/evos*
    rm -rf evos-cli_ubuntu-16.04-x64.tar.bz2
    wget https://github.com/EVOS-DEV/evos-core/releases/download/1.1.3/evos-1.1.3-ubuntu-daemon.tgz
    tar -xvf evos-1.1.3-ubuntu-daemon.tgz
    sudo chmod -R 755 evos-cli
    sudo chmod -R 755 evosd
    cp -p -r evosd /usr/local/bin
    cp -p -r evos-cli /usr/local/bin
    rm -rf *ubuntu-daemon.tgz
    rm -rf *ubuntu-daemon.tgz
    evosd -daemon
    evos-cli --version
	echo -e "${GREEN} Daemon Succesfully updated! ${NC}"
	echo -e "${GREEN} Confirming Daemon status... ${NC}"
	fi
	
#Checked Status
sleep 3s
echo -e "${GREEN} Status Checked! ${NC}"
sleep 1s

#Bootstrap Installation 
echo "Do you want me to install Bootstrap?[y/n]"
read DOSETUP

if [[ $DOSETUP =~ "n" ]] ; then
      echo -e "${YELLOW}Bootstrap Installation is aborted... ${NC}"
      echo -e "${GREEN}For installing updates or bootstrap in future, use ${CYAN}bash evos-autoupdate.sh  ${NC}"
      sleep 1s
      echo -e "${BLUE}Exitting updater... ${NC}"
      sleep 2s
      exit 1
fi

if [[ $DOSETUP =~ "y" ]] ; then
      echo -e "${GREEN}I will install bootstrap, will stop Server soon ... ${NC}"
	  sleep 1s
	  echo -e "${GREEN}Stopping Server and preparing installation... ${NC}"
	  evos-cli stop
	  sleep 2s
	  rm -rf .evos/blocks .evos/chainstate
      echo -e "${GREEN} Removing the current blockchain data... ${NC}"
      sleep 2s
      echo -e "${GREEN} I will start downloading the blockchain files in 5 seconds... ${NC}"
      sleep 5s
	  wget http://289623_web.fakaheda.eu/evos/evosbootstrap.zip
	  sleep 2s
	  echo -e "${GREEN} Now i will install the actual blockchain data! ${NC}"
	  sleep 1s
	  sudo apt-get install unzip
	  unzip evosbootstrap.zip -d .evos
	  echo -e "${GREEN} Files succesfully installed! ${NC}"
	  sleep 1s
      echo -e "${GREEN} Removing .zip file from your directory ${NC}"
	  rm -rf evosbootstrap.zip 
	  echo -e "${GREEN} Starting the Server... ${NC}"
	  sleep 1s
	  evosd -daemon
	  evos-cli --version
	  rm -rf evos-updatepro.sh
	  echo -e "${GREEN} For installing updates or bootstrap in future, use ${BLUE}bash evos-autoupdate.sh  ${NC}"
else
      echo -e "${RED}Bootstrap Installation has failed... ${NC}"
	  sleep 2s 
	  evos-cli --version
	  rm -rf evos-updatepro.sh
	  echo -e "${GREEN} For installing updates or bootstrap in future, use ${CYAN}bash evos-autoupdate.sh  ${NC}"
fi
