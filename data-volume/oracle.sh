#/bin/sh

# https://github.com/zhu915139481/docker-oracle-xe-11g  

# first create oracle data volume  
docker run --rm --name oracle -v /home/data/oracle/data:/u01/app/oracle sath89/oracle-xe-11g  

# create oracle container  

##Consider this formula before customizing:
#processes=x
#sessions=x*1.1+5
#transactions=sessions*1.1
docker run -d -p 8080:8080 -p 1521:1521 --name oracle \
-v /home/data/oracle/data:/u01/app/oracle \
-e processes=1000 \
-e sessions=1105 \
-e transactions=1215 \
sath89/oracle-xe-11g
