#!/bin/bash

#Color codes
RED='\033[0;91m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

evos-cli stop
echo -e "${GREEN} Stopped the Evos Server ${NC}"
sleep 2s
rm -rf .evos/blocks .evos/chainstate
echo -e "${GREEN} Removing the current blockchain data... ${NC}"
sleep 2s
echo -e "${GREEN} I will start downloading the blockchain files in 5 seconds... ${NC}"
sleep 5s
wget http://289623_web.fakaheda.eu/evos/evosbootstrap.zip
sleep 2s
echo -e "${GREEN} Now i will install the actual blockchain data! ${NC}"
sudo apt-get install unzip
unzip evosbootstrap.zip -d .evos 
echo -e "${GREEN} Files succesfully installed! ${NC}"
sleep 1s
echo -e "${GREEN} Removing .zip file from your directory ${NC}"
rm -rf evosbootstrap.zip 
echo -e "${GREEN} Starting the Server... ${NC}"
evosd -daemon
evos-cli --version


