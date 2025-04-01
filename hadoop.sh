sudo docker run --hostname=quickstart.cloudera --privileged=true -d -it \
-p 2181:2181 \
-p 7077:7077 \
-p 7180:7180 \
-p 8020:8020 \
-p 8022:8022 \
-p 8042:8042 \
-p 8080:8080 \
-p 8088:8088 \
-p 8888:8888 \
-p 8983:8983 \
-p 9090:9090 \
-p 11000:11000 \
-p 16000:16000 \
-p 19888:19888 \
-p 50030:50030 \
-p 50070:50070 \
-p 50075:50075 \
-p 60010:60010 \
-p 60030:60030 \
-v ~/comp4651-exercise-1/:/host \
--memory 8g \
--name cloudera_quickstart \
csit6000o/quickstart:latest \
/etc/bootstrap.sh -bash

sudo docker exec cloudera_quickstart bash -c "echo \"source /etc/environment\" >> /root/.bashrc"

# run the following command to get into the container
# sudo docker exec -it cloudera_quickstart bash

