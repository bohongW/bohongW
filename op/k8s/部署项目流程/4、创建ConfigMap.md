# ConfigMap
***
```txt
ConfigMap是一种API对象，用来将非加密数据保存到键值对中。可以用作环境变量、命令行参数或者存储卷中的配置文件。
ConfigMap可以将环境变量配置信息和容器镜像解耦，便于应用配置的修改。如果需要存储加密信息时可以使用Secret对象。
```

## 创建ConfigMap
> kubectl create cm --from-file=$FILE_NAME -n $NAMESPACE

> kubectl create cm dir-config --from-file=$FILE_PATH -n $NAMESPACE

> kubectl create cm dir-config --from-file=$FILE_PATH -n NAMESPACE

> kubectl create -f $FILE_NAME
```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: test-redis-conf
  namespace: test
data:
    redis.conf: |
      daemonize no
      pidfile /var/run/redis.pid
      port 6379
      bind 0.0.0.0
      timeout 0
      loglevel notice
      databases 16
      save 900 1
      save 300 10
      save 60 10000
      rdbcompression yes
      dbfilename dump.rdb
      dir /data
      maxclients 128
      requirepass dxheIicL1M
      appendonly yes
      appendfilename appendonly.aof
      appendfsync everysec
      no-appendfsync-on-rewrite no
      auto-aof-rewrite-percentage 100
      auto-aof-rewrite-min-size 256mb
      slowlog-log-slower-than 1000000
      slowlog-max-len 128
      client-output-buffer-limit normal 0 0 0
      hz 10
      aof-rewrite-incremental-fsync yes
```

> 注意：
``建议Yaml配置文件部署configMap``