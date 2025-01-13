#!/bin/bash

if [ -f /opt/spt-server/SPT.Server ]; then
  appHash=$(md5sum /app/spt-server/SPT.Server | awk '{ print $1 }')
  exeHash=$(md5sum /opt/spt-server/SPT.Server | awk '{ print $1 }')
  if [ "$appHash" = "$exeHash" ]; then
    echo "MD5 verification successful!"
  else
    echo "MD5 mismatch, copy files to /opt/spt-server."
    cp -r /app/spt-server /opt
    echo "Finished!"
  fi
else
  echo "Program is not found, copy files to /opt/spt-server."
  cp -r /app/spt-server /opt
  echo "Finished!"
fi

cd /opt/spt-server

if [ -z "$backendIp" ]; then
  IP=$(hostname -I | awk '{print $1}')
else
  IP=$backendIp
fi

if [ -z "$backendPort" ]; then
  PORT=6969
else
  PORT=$backendPort
fi

if [ -z "$webSocketPingDelayMs" ]; then
  PINGDELAYMS=90000
else
  PINGDELAYMS=$webSocketPingDelayMs
fi

sed -Ei "s/\"ip\": \"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\",/\"ip\": \"0.0.0.0\",/g" SPT_Data/Server/configs/http.json
sed -Ei "s/\"port\": ([0-9]|[1-9][1-9]{1,3}|[1-5][0-9]{4}|6[1-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5]),/\"port\": ${PORT},/g" SPT_Data/Server/configs/http.json
sed -Ei "s/\"backendIp\": \"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\",/\"backendIp\": \"${IP}\",/g" SPT_Data/Server/configs/http.json
sed -Ei "s/\"backendPort\": ([0-9]|[1-9][1-9]{1,3}|[1-5][0-9]{4}|6[1-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5]),/\"backendPort\": ${PORT},/g" SPT_Data/Server/configs/http.json
sed -Ei "s/\"webSocketPingDelayMs\": ([0-9]{1,}),/\"webSocketPingDelayMs\": ${PINGDELAYMS},/g" SPT_Data/Server/configs/http.json

chmod +x SPT.Server && ./SPT.Server

