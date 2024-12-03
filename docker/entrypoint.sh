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

sed -i "0,/127.0.0.1/s/127.0.0.1/${IP}/" SPT_Data/Server/configs/http.json
sed -i "s/[0-9]\{1,\},/${PORT},/g" SPT_Data/Server/configs/http.json
tac SPT_Data/Server/configs/http.json | sed "0,/${PORT},/s/${PORT},/$webSocketPingDelayMs,/" | tac | tee SPT_Data/Server/configs/http.json > /dev/null

chmod +x SPT.Server && ./SPT.Server

