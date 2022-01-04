# README.md
## Create PV & PVC
```shell
kubectl create -f storage.yaml
```
> 注意事项：

- 1、EBS可用区需和Node节点在同一可用区
- 2、注意回收策略以及读写策略

## Create ConfigMap
```shell
kubectl create -f configmap.yaml
```
> 注意事项：
- 1、名称配置文件错误导致无法启动
  
## Create SVC
```shell
kubectl create -f svc.yaml
```
> 注意事项：
- 1、pod端口的修改
## Create Redis
```shell
kubectl create -f redis.yaml
```
> 注意事项
- 1、服务类型
- 2、更新方式
- 3、启动命令
- 4、资源限制
- 5、配置文件挂在
- 6、持久卷挂载

