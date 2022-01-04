# 创建volumes

## Volume、PV、PVC
```txt
Volume：存储实例，物理存储
PV：persistentVolume，外部存储系统中的一块存储空间，由管理员创建和维护。与 Volume 一样，PV 具有持久性，生命周期独立于 Pod。
PVC：persistentVolumeClami，对 PV 的申请 (Claim)。PVC 通常由普通用户创建和维护。需要为 Pod 分配存储资源时，用户可以创建一个 PVC，指明存储资源的容量大小和访问模式（比如只读）等信息，Kubernetes 会查找并提供满足条件的 PV。
```

## 创建PV
```yaml
apiVersion: v1
# PV资源类型
kind: PersistentVolume
# PV没有NAMESPACE限制
metadata:
  name: pv-test-redis-5gb-ebs-01-vol-029b74bf3ed0e5f5b
  labels:
    app: test-redis
spec:
  # 访问模式
  accessModes:
  - ReadWriteOnce
  # AWS
  awsElasticBlockStore:
    # 文件系统类型
    fsType: ext4
    # 卷ID、需要先在AWS上创建，且与NODE节点保持相同可用区
    volumeID: aws://ap-northeast-2c/vol-029b74bf3ed0e5f5b
  capacity:
    # 存储卷大小、不能超过物理存储大小
    storage: 5Gi
  # 亲和性
  nodeAffinity:
    required:
      # 节点选择器
      nodeSelectorTerms:
      - matchExpressions:
        - key: topology.kubernetes.io/zone
          operator: In
          values:
          - ap-northeast-2c
        - key: topology.kubernetes.io/region
          operator: In
          values:
          - ap-northeast-2
  # PV回收策略
  persistentVolumeReclaimPolicy: Retain
  # PV物理磁盘类型
  storageClassName: gp2
  volumeMode: Filesystem
```
> 注意：
``PV没有NAMESPACE限制``
``PV可用区必须与NODE节点保持同一可用区，否则会出现亲和性错误``
``PV存储大小不能大于物理存储空间大小``
##### PV回收模式
- 1、
## 创建PVC
```yaml
apiVersion: v1
# PVC资源类型
kind: PersistentVolumeClaim
# PVC有NAMESPACE隔离限制
metadata:
  name: pvc-test-redis-5gb-ebs-01
  namespace: test
  labels:
    app: test-redis
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: gp2
  volumeMode: Filesystem
  volumeName: pv-test-redis-5gb-ebs-01-vol-029b74bf3ed0e5f5b
```
> 注意：
``PVC存储大小不能超过PV存储大小``