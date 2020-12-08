#!/bin/sh
# This script configures replica set by adding members for Shard and Config server and making mongos router aware of sharded replica set.
config_serverName1=mongoconfig1
config_serverName2=mongoconfig2
config_serverName3=mongoconfig3
config_replicasetName=mongoreplicaset1conf

shard1_name=mongoshard1
shard2_name=mongoshard2
shard3_name=mongoshard3
shard_replicasetName=mongoreplicaset1shard

mongosRouter1_name=mongosrouter1
mongosRouter2_name=mongosrouter2

#Map Config server replica set with rs.initiate
sudo docker exec -it ${config_serverName1} bash -c \
"echo 'rs.initiate({_id: \"${config_replicasetName}\",configsvr: true, \
members: [{ _id : 0, host : \"${config_serverName1}\" },{ _id : 1, host : \"${config_serverName2}\" }, { _id : 2, host : \"${config_serverName3}\" }]})' | mongo" 


echo "Map Config server replica set with rs.initiate ..."



sudo docker exec -it ${shard1_name} bash -c \
"echo 'rs.initiate({_id : \"${shard_replicasetName}1\", \
members: [{ _id : 0, host : \"${shard1_name}\" }]})' | mongo" 

sudo docker exec -it ${shard2_name} bash -c \
"echo 'rs.initiate({_id : \"${shard_replicasetName}2\", \
members: [{ _id : 0, host : \"${shard2_name}\" }]})' | mongo" 

sudo docker exec -it ${shard3_name} bash -c \
"echo 'rs.initiate({_id : \"${shard_replicasetName}3\", \
members: [{ _id : 0, host : \"${shard3_name}\" }]})' | mongo" 

echo "Map Shard replica set to its associated members with rs.initiate..."


sleep 20
# 如果以下执行失败，可单独再执行一遍

sudo docker exec -it ${mongosRouter1_name} bash -c "echo 'sh.addShard(\"mongoreplicaset1shard1/mongoshard1:27017\")' | mongo" 
sudo docker exec -it ${mongosRouter1_name} bash -c "echo 'sh.addShard(\"mongoreplicaset1shard2/mongoshard2:27017\")' | mongo" 
sudo docker exec -it ${mongosRouter1_name} bash -c "echo 'sh.addShard(\"mongoreplicaset1shard3/mongoshard3:27017\")' | mongo" 

echo "Configure Mongos-router with sh.addShard ..."

