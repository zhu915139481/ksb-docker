
--- 临时表空间
create temporary  tablespace ccla_temp tempfile  '/u01/app/oracle/oradata/ccla/ccla-temp.dbf'
size 50M
autoextend on next 50M
maxsize unlimited
extent management local;
--- ccla 表空间
create  tablespace ccla datafile '/u01/app/oracle/oradata/ccla/ccla.dbf'
size 50M
autoextend on next 50M
maxsize unlimited
extent management local autoallocate
segment space management auto;
--- jsldxh 表空间
create  tablespace jsldxh datafile '/u01/app/oracle/oradata/ccla/jsldxh.dbf'
size 50M
autoextend on next 50M
maxsize unlimited
extent management local autoallocate
segment space management auto;


--  ccla_kspx 表空间
declare

type str_array is varray(30) of varchar2(100);
ts_names str_array := str_array('content','organization','course','user','train','exam','question_db'
                                ,'question_test','commons','file','log','msg','order','tj','resources','ws','dictionary');

ts_name varchar2(20);
ts_file_name varchar2(100);

ddl_sql varchar2(500);

begin

  -- 循环数组
  for i in 1..ts_names.count loop
    
    ts_name := 'ccla_'||ts_names(i);
    ts_file_name := '''/u01/app/oracle/oradata/ccla/ccla-'||ts_names(i)||'.dbf''';
    
    --execute immediate 'drop tablespace '||ts_name;
    
    ddl_sql := '
    create  tablespace '||ts_name||' datafile '||ts_file_name||'
    size 50M
    autoextend on next 50M
    maxsize unlimited
    extent management local autoallocate
    segment space management auto
    ';
    --dbms_output.put_line(ddl_sql);
    execute immediate ddl_sql;
    
  end loop;

end;

-- 创建用户

-- Create the user 
create user JSLDXH
  default tablespace JSLDXH
  temporary tablespace CCLA_TEMP
  profile DEFAULT;
-- Grant/Revoke role privileges 
grant connect to JSLDXH;
grant dba to JSLDXH;
-- Grant/Revoke system privileges 
grant unlimited tablespace to JSLDXH;

-- Create the user 
create user CCLA
  default tablespace CCLA
  temporary tablespace CCLA_TEMP
  profile DEFAULT;
-- Grant/Revoke role privileges 
grant connect to CCLA;
grant dba to CCLA;
-- Grant/Revoke system privileges 
grant unlimited tablespace to CCLA;


-- Create the user 
create user CCLA_KSPX
  default tablespace CCLA_COMMONS
  temporary tablespace CCLA_TEMP
  profile DEFAULT;
-- Grant/Revoke role privileges 
grant connect to CCLA_KSPX;
grant dba to CCLA_KSPX;
-- Grant/Revoke system privileges 
grant unlimited tablespace to CCLA_KSPX;



