# POD
---
```txt
在Kubernetes集群中，Pod是所有业务类型的基础，也是K8S管理的最小单位级，它是一个或多个容器的组合。这些容器共享存储、网络和命名空间，以及如何运行的规范。在Pod中，所有容器都被同一安排和调度，并运行在共享的上下文中。对于具体应用而言，Pod是它们的逻辑主机，Pod包含业务相关的多个应用容器。

网络:每一个Pod都会被指派一个唯一的Ip地址，在Pod中的每一个容器共享网络命名空间，包括Ip地址和网络端口。在同一个Pod中的容器可以同locahost进行互相通信。当Pod中的容器需要与Pod外的实体进行通信时，则需要通过端口等共享的网络资源。

存储:Pod能够被指定共享存储卷的集合，在Pod中所有的容器能够访问共享存储卷，允许这些容器共享数据。存储卷也允许在一个Pod持久化数据，以防止其中的容器需要被重启。
```
## 工作方式

<font color=#FF00565 size=4px>K8s一般不直接创建Pod。 而是通过控制器和模版配置来管理和调度</font>

> 常见调度器
``Deployment：Deployment是一个定义及管理多副本应用（即多个副本 Pod）的新一代对象，与Replication Controller相比，它提供了更加完善的功能，使用起来更加简单方便。``
`` ``
``StatefulSet：StatefulSet是为了解决有状态服务的问题（对应Deployments和ReplicaSets是为无状态服务而设计）``
``稳定的持久化存储，即Pod重新调度后还是能访问到相同的持久化数据，基于PVC来实现``
``稳定的网络标志，即Pod重新调度后其PodName和HostName不变，基于Headless Service（即没有Cluster IP的Service）来实现``
``有序部署，有序扩展，即Pod是有顺序的，在部署或者扩展的时候要依据定义的顺序依次依次进行（即从0到N-1，在下一个Pod运行之前所有之前的Pod必须都是Running和Ready状态），基于init containers来实现有序收缩，有序删除（即从N-1到0)``

作者：每天进步一典
链接：https://www.jianshu.com/p/959fe1b91efa
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。``

## APP创建流程
```markdown
- 镜像打包
- 提交到镜像仓库仓库
```
> 注意：
``可能会涉及到重命名镜像``
``频繁更新若镜像不删除会导致存储空间越来越大``

## Pod部署
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: test-redis
  namespace: test
  labels:
    app: test-redis
spec:
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      partition: 1
  selector:
    matchLabels:
      app: test-redis
  serviceName: test-redis-svc
  replicas: 1
  template:
    metadata:
      labels:
        app: test-redis
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: test-redis
        image: redis
        imagePullPolicy: IfNotPresent
        command:
        - sh
        args:
        - -c
        - redis-server
        - /opt/redis.conf
        resources:
          requests:
            cpu: 500m
            memory: 512Mi
          limits:
            cpu: 1000m
            memory: 2048Mi
        ports:
        - containerPort: 6379
          protocol: TCP
          name: test-redis
        volumeMounts:
        - name: test-redis-conf
          mountPath: /opt
        - name: test-redis-data
          mountPath: /data
      restartPolicy: Always
      volumes:
      - name: test-redis-data
        persistentVolumeClaim:
          claimName: pvc-test-redis-5gb-ebs-01
      - name: test-redis-conf
        configMap:
          name: test-redis-conf
```
