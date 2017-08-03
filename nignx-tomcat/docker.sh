#!/bin/sh

#auther:zhuguojie
#date:2017��8��1�� 18:46:26

#����SElinux
setenforce 0

#�����������������
case $1 in
  
  install )
    #��ʼ��������

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
    #��������
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

  stop )
    #�ر�����
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

  restart )
    #��������
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

  delete )
    #ɾ������
    docker rm -fv ccla-zsgl ksb-front ksb-admin ksb-weixin ksb-cgi nginx
  ;;

esac