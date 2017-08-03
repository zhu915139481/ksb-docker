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
    
    docker rm -fv nginx
    
    docker run \
        --name nginx -h nginx \
        -v /home/data/nginx/html:/usr/share/nginx/html \
        -v /home/data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
        -v /home/data/nginx/conf/servers:/etc/nginx/servers \
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
    docker start ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi
  ;;

  stop )
    #关闭容器
    docker stop ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi
  ;;

  restart )
    #重启容器
    docker restart ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi
  ;;

  delete )
    #删除容器
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi
  ;;

esac

setenforce 1
