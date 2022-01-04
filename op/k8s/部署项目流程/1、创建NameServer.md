# Namespace
***
```txt
在一个Kubernetes集群中可以拥有多个命名空间，它们在逻辑上彼此隔离。 他们可以为您和您的团队提供组织，安全甚至性能方面的帮助！
```

## 创建Namespace
> kubectl create ns -f $NAMESERVER_NAME
```yaml
apiVersion: v1
kind: Namespace
metadata:
  lables:
    project: xxxx   
    env: xxxx
  name: test
```
> 注意：
``尽量以项目命名，避免亲和性``
``标签尽量详细，如：项目名称、环境等等``