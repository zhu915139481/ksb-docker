#!/bin/sh

#auther:zhuguojie
#date:2017年8月1日 18:46:26

#设置SElinux
setenforce 0

#根据输入参数做处理
case $1 in
  
  install )
    #初始加载容器

    docker run \
        --name ccla-zsgl -h ccla-zsgl \
        -v /home/data/tomcats/conf/server.xml:/usr/local/tomcat/conf/server.xml \
        -d tomcat:7.0.79

    docker run \
        --name ksb-front -h ksb-front \
        -v /home/data/tomcats/conf/server.xml:/usr/local/tomcat/conf/server.xml \
        -d tomcat:7.0.79

    docker run \
        --name ksb-admin -h ksb-admin \
        -v /home/data/tomcats/conf/server.xml:/usr/local/tomcat/conf/server.xml \
        -d tomcat:7.0.79

    docker run \
        --name ksb-weixin -h ksb-weixin \
        -v /home/data/tomcats/conf/server.xml:/usr/local/tomcat/conf/server.xml \
        -d tomcat:7.0.79

    docker run \
        --name ksb-cgi -h ksb-cgi \
        -v /home/data/tomcats/conf/server.xml:/usr/local/tomcat/conf/server.xml \
        -d tomcat:7.0.79
    
    docker run \
        --name nginx -h nginx \
        -v /home/data/nginx/html:/usr/share/nginx/html:ro \
        -v /home/data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
        -v /home/data/nginx/conf/servers:/etc/nginx/servers:ro \
        --link ccla-zsgl:ccla-zsgl \
        --link ksb-front:ksb-front \
        --link ksb-admin:ksb-admin \
        --link ksb-weixin:ksb-weixin \
        --link ksb-cgi:ksb-cgi \
        -p 80:80 \
        -d nginx

  ;;

  start )
    #启动容器
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

  stop )
    #关闭容器
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

  restart )
    #重启容器
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

  delete )
    #删除容器
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

esac