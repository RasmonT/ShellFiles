#!/bin/bash

RED='\033[0;91m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 

echo -e "${GREEN} Preparing actual script to start. ${NC}"
sleep 1s
wget https://raw.githubusercontent.com/RasmonT/TestFiles/master/esbc-updatepro.sh
sleep 2s
bash esbc-updatepro.sh