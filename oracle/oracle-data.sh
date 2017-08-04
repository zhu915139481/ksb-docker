#/bin/sh

# https://github.com/zhu915139481/docker-oracle-xe-11g  

ORACLE_DATA=/home/data/oracle/data
ORACLE_PORT=1521
ORACLE_WEB_PORT=8080

ORACLE_HOME=/u01/app/oracle

ORACLE_DATA_CONTAINER_NAME=oracle-data
ORACLE_CONTAINER_NAME=oracle

volume(){

    # create oracle data volume  建立oracle数据卷，保存在宿主机上，用于保存oracle数据
    docker run --name $ORACLE_DATA_CONTAINER_NAME sath89/oracle-xe-11g  

}

oracle(){

  # create oracle container 运行oracle容器，依据已存在的oracle数据卷 

  ##Consider this formula before customizing:
  #processes=x
  #sessions=x*1.1+5
  #transactions=sessions*1.1
  
  #挂载oracle数据卷
  docker run -d -p $ORACLE_WEB_PORT:8080 -p $ORACLE_PORT:1521 \
  --name $ORACLE_CONTAINER_NAME \
  --volumes-from $ORACLE_DATA_CONTAINER_NAME \
  -e processes=1000 \
  -e sessions=1105 \
  -e transactions=1215 \
  sath89/oracle-xe-11g
  
  docker logs -f $ORACLE_CONTAINER_NAME

}

#根据输入参数做处理
case $1 in
  
  install-volume )
  
    volume
    
  ;;
  
  install )
  
    oracle
  
  ;;
  
  install-all )
  
    volume
    
    oracle
  
  ;;
  
  stop )
  
  docker stop $ORACLE_CONTAINER_NAME
  
  ;;
  
  start )
  
  docker start $ORACLE_CONTAINER_NAME
  
  ;;
  
  restart )
  
  docker restart $ORACLE_CONTAINER_NAME
  
  ;;
  
  delete )
  
  docker rm -fv $ORACLE_CONTAINER_NAME
  
  ;;
  
  delete-volume )
  
  docker rm -fv $ORACLE_DATA_CONTAINER_NAME
  
  ;;
  
  delete-all )
  
  docker rm -fv $ORACLE_CONTAINER_NAME
  
  docker rm -fv $ORACLE_DATA_CONTAINER_NAME
  
  ;;
  
  backup )
  
  setenforce 0 
  docker run --rm --volumes-from $ORACLE_DATA_CONTAINER_NAME -v $(pwd):/backup busybox tar cvf /backup/backup.tar $ORACLE_HOME
  setenforce 1 
  
  ;;
  
esac
