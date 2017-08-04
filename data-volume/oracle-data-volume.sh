#/bin/sh

# https://github.com/zhu915139481/docker-oracle-xe-11g  

setenforce 0

# create oracle data volume  建立oracle数据卷，保存在宿主机上，用于保存oracle数据
docker run --rm --name oracle -v /home/data/oracle/data:/u01/app/oracle sath89/oracle-xe-11g  

setenforce 1
