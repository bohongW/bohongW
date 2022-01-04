# Service

***
```txt
Service是一种可以访问Pod逻辑分组的策略， Service通常是通过 Label Selector访问Pod组。
Service有多种类型：
　　1. ExternalName: 用于将集群外部的服务引入到集群内部，在集群内部可直接访问来获取服务。
　　　　　　它的值必须是 FQDN, 此FQDN为集群内部的FQDN, 即: ServiceName.Namespace.Domain.LTD.
　　　　　　然后CoreDNS接受到该FQDN后，能解析出一个CNAME记录, 该别名记录为真正互联网上的域名.
　　　　　　如: www.test.com, 接着CoreDNS在向互联网上的根域DNS解析该域名，获得其真实互联网IP.
　　2. ClusterIP： 用于为集群内Pod访问时,提供的固定访问地址,默认是自动分配地址,可使用ClusterIP关键字指定固定IP.
　　3. NodePort: 用于为集群外部访问Service后面Pod提供访问接入端口.
　　　　这种类型的service工作流程为:
　　　　　　Client----->NodeIP:NodePort----->ClusterIP:ServicePort----->PodIP:ContainerPort
　　4. LoadBalancer: 用于当K8s运行在一个云环境内时,若该云环境支持LBaaS,则此类型可自动触发创建
　　　　　　　　一个软件负载均衡器用于对Service做负载均衡调度.
　　　　因为外部所有Client都访问一个NodeIP,该节点的压力将会很大, 而LoadBalancer则可解决这个问题。
　　　　而且它还直接动态监测后端Node是否被移除或新增了，然后动态更新调度的节点数。
```

## 创建Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc
  namespace: nginx
spec:
  ipFamilies: IPv4
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 80
  sessionAffinity: None
  type: ClusterIP
  selector:
    app: nginx
```
> 注意：
``Service模式为多种类型``
``ClusterIP设置，NONE/IP，若无特殊要求尽量不写``
