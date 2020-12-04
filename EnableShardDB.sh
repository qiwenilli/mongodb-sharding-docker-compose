#!/bin/sh

#Create DB
sudo docker exec -it mongosrouter1 bash -c "echo 'use nbxDB' | mongo"
#Enable sharding on DB
sudo docker exec -it mongosrouter1 bash -c "echo 'sh.enableSharding(\"nbxDB\")' | mongo"
#Create Collection 
sudo docker exec -it mongosrouter1 bash -c "echo 'db.createCollection(\"nbxDB.nbximage\")' | mongo "
#Create Collection based on the hased shard key _id
sudo docker exec -it mongosrouter1 bash -c "echo 'sh.shardCollection(\"nbxDB.nbximage\", {\"_id\" : \"hashed\"})' | mongo"
