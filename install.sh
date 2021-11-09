#!/bin/bash

docker stop $(docker ps -qa)
docker rm $(docker ps -qa)

systemctl start docker
rm -rf /var/lib/drone

# 變數區域
# DRONE_GITHUB_CLIENT_ID = 
# DRONE_GITHUB_CLIENT_SECRET = 
# DRONE_RPC_SECRET = 
# DRONE_SERVER_HOST = 
# DRONE_SERVER_PROTO = 

# TG_TOKEN = 
# TG_CHATID = 
# TG_MESSAGE = 

# 主程式區域

docker run \
  --volume=/var/lib/drone:/data \
  --env=DRONE_GITHUB_CLIENT_ID=__REACTED__ \
  --env=DRONE_GITHUB_CLIENT_SECRET=__REACTED__ \
  --env=DRONE_RPC_SECRET=__REACTED__ \
  --env=DRONE_SERVER_HOST=192.168.50.200 \
  --env=DRONE_SERVER_PROTO=http \
  --publish=80:80 \
  --publish=443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:2

docker run --detach \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --env=DRONE_RPC_PROTO=http \
  --env=DRONE_RPC_HOST=192.168.50.200 \
  --env=DRONE_RPC_SECRET=__REACTED__ \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_RUNNER_NAME=my-first-runner \
  --publish=3000:3000 \
  --restart=always \
  --name=runner \
  drone/drone-runner-docker:1
  
  # curl TG 
