#!/bin/sh
echo "eula=true" > eula.txt
java -Xmx2G -Xms2G -jar server.jar nogui