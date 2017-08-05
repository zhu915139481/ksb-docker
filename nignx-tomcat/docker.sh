#!/bin/sh

#auther:zhuguojie
#date:2017年8月1日 18:46:26

#设置SElinux
#setenforce 0

#oracle容器名称
ORACLE_NAME=oracle
#其他容器内联oracle主机名，用于连接oracle服务
ORACLE_DB_NAME=oracle

#配置文件
TOMCAT_CONF=/home/data/tomcats
NGINX_CONF=/home/data/nginx

#nginx容器名称
NGINX_NAME=nginx
#所有的Tomcat名称
TOMCAT_NAMES="ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi"

#根据输入参数做处理
case $1 in
  
  install )
  
    #添加selinux规则，改变要挂载的目录的安全性文本
    chcon -Rt svirt_sandbox_file_t $NGINX_CONF $TOMCAT_CONF
    
    #tomcat容器连接
    links=""
    #初始加载容器
    for tomcat in $TOMCAT_NAMES
    do

      docker run \
        --name $tomcat -h $tomcat \
        -v $TOMCAT_CONF/conf/server.xml:/usr/local/tomcat/conf/server.xml \
        --link $ORACLE_NAME=$ORACLE_DB_NAME \
        -d tomcat:7.0.79
      
      links=$links --link $tomcat:$tomcat

    done
    
    docker rm -fv $NGINX_NAME
    
    docker run \
        --name $NGINX_NAME -h $NGINX_NAME \
        -v $NGINX_CONF/html:/usr/share/nginx/html \
        -v $NGINX_CONF/conf/nginx.conf:/etc/nginx/nginx.conf \
        -v $NGINX_CONF/conf/servers:/etc/nginx/servers \
        $links \
        -p 80:80 \
        -d nginx

  ;;

  start )
    #启动容器
    docker start $TOMCAT_NAMES
  ;;

  stop )
    #关闭容器
    docker stop $TOMCAT_NAMES
  ;;

  restart )
    #重启容器
    docker restart $TOMCAT_NAMES
  ;;

  delete )
    #删除容器
    docker rm -fv $TOMCAT_NAMES
  ;;

esac
