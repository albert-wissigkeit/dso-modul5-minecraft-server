#!/bin/sh
if [ "${MC_EULA}" = true ]
then
   echo "eula=true" > eula.txt
   sed -i "s/^level-name=.*/level-name=${LEVEL_NAME}/" server.properties
   sed -i "s/^difficulty=.*/difficulty=${DIFFICULTY}/" server.properties
   sed -i "s/^gamemode=.*/gamemode=${GAMEMODE}/" server.properties
   sed -i "s/^max-players=.*/max-players=${MAX_PLAYERS}/" server.properties
   sed -i "s/^white-list=.*/white-list=${WHITE_LIST}/" server.properties
   sed -i "s/^view-distance=.*/view-distance=${VIEW_DISTANCE}/" server.properties
   sed -i "s/^motd=.*/motd=${MOTD}/" server.properties
   sed -i "s/^server-port=.*/server-port=${MINECRAFT_SERVER_PORT}/" server.properties
   echo "EULA confirmed and server.properties adjusted, server is starting, please wait..."
else
   echo "You must set the EULA to true in .env, otherwise nothing will start!"
   exit 0
fi
java -Xmx${MAX_RAM}G -Xms${START_RAM}G -jar server.jar nogui