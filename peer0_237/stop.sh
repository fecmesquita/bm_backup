#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
red=$'\e[1;31m'
cyan=$'\e[1;36m'
end=$'\e[0m'
set -e

# Shut down the Docker containers that might be currently running.
docker-compose -f docker-compose.yml stop
echo "${cyan}Stopped containers that might be running.${end}"

#Remove webapplication embedded database h2
sudo rm -f /home/CUP/cup/webapp-volume/h2db/webappdb.mv.db
echo "${cyan}Webapplication embedded database h2 removed.${end}"

#Remove admin.jso and hfuse.jso users created by the webapplication
sudo rm -f /home/CUP/cup/webapp-volume/minerva/admin.jso /home/CUP/cup/webapp-volume/minerva/hfuser.jso
echo "${cyan}Webapp admin.jso and hfuse.jso users removed.${end}"

#Remove tomcat webapplication folder content if -remWebapp flag
if [[ $1 -eq "-remWebapp" ]] ; then
    echo "${cyan}Removing tomcat webapplication folder content...${end}"
    sudo rm -rf /home/CUP/cup/webapp-volume/webapps/CRMMock
fi

#Remove webapplication logs if -remLogs flag
#if [[ $1 -eq "-remWebapp" ]] ; then
    #echo "${cyan}Removing webapplication logs...${end}"
    #ls | grep -P "/home/CUP/cup/webapp-volume/minerva/FILE_.*" | xargs -d"\n" rm
    #sudo rm -rf /home/CUP/cup/webapp-volume/minerva/FILE_.*
#fi