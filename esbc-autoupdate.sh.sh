#!/bin/bash

RED='\033[0;91m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 

#Update the file 
echo -e "${GREEN} I will remove script data and download new one. ${NC}"
rm -rf esbc-updatepro.sh
sleep 1s
wget https://github.com/RasmonT/TestFiles/edit/master/esbc-updatepro.sh
sleep 2s
bash esbc-updatepro.sh