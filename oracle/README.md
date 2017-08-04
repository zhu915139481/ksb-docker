# 数据卷
> 利用docker的数据卷特性，建立专一的共享数据卷，用于共享数据和备份、迁移数据。基于docker官网的busybox  

## oracle数据卷  
  install-volume、install、stop、start、restart、delete、delete-volume、delete-all  
  数据恢复:  
    建立数据卷  
    docker run -v /u01/app/oracle --name oracle-data busybox /bin/sh  
    建立恢复使用的临时容器  
    docker run -it --volumes-from oracle-data -v $(pwd):/backup --name worker busybox /bin/sh  
        cd /  
        tar xvf /backup/backup.tar  
        exit
    docker rm -fv worker
    
    
## nginx配置文件、日志数据卷  

## tomcat war包共享、日志数据卷  
