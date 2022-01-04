# Postgresql

## 安装
- 1、下载源代码
- 2、解压
- 3、安装依赖
```txt
yum install -y make make-devel gcc gcc-c++
```
- 4、创建用户
```shell
useradd postgres
```
- 5、编译
```shell
cd $POSTGRESQL_SOURCE_FILE_PATH
./configure --prefix=$POSTGRESQL_INSTALL_PATH
```
- 6、创建数据目录
```shell
mkdir -p $POSTGRESQL_DATA_PATH
```
- 7、添加环境变量
```shell
cat > /etc/profile.d/postgresql.sh <<EOF
export PG_HOME=$POSTGRESQL_INSTALL_PATH
export PGDATA="\$PG_HOME/data"
export PATH="\$PG_HOME/bin/:\$PATH"
EOF
```
- 8、初始化数据库
```shell
initdb -D $POSTGRESQL_DATA_PATH
```
- 9、启动服务
```shell
pg_ctl -D $POSTGRESQL_DATA_PATH -l $POSTGRESQL_LOG_PATH start
```

## 使用
- 1、修改配置文件
- 2、创建用户
```sql
# 创建ROLE并赋予CREATEDB和LOGIN权限
create ROLE $USER_NAME CREATEDB PASSWORD "$PASSWORD" LOGIN;
# 查询ROLE
SQL: select * from pg_role;
```
- 3、创建数据库
```sql
create database $DATABASE_NAME owner $USER_NAME;
# 查询库
select * from pg_database;
```
> 注意：
```sql
# 需要先授权才能使用$USER_NAME连接到$DATABASE_NAME
# 授权$DATABASE_NAME数据库所有权限给$USER_NAME
grant all on database $DATABASE_NAME to $USER_NAME;
```
- 4、创建schema
```sql
create schema $SCHEMA_NAME;
# 查询schema
select * from pg_namespace;
```

- 5、创建表
```sql
create table $SCHEMA_NAME.$TABLE_NAME(id int);
# 查询所有表
select * from pg_tables;
```
