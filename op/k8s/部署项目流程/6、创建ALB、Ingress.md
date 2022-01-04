# 创建Ingress网关
***
```txt
Ingress 使用开源的反向代理负载均衡器来实现对外暴漏服务，比如 Nginx、Apache、Haproxy等
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-nginx-test-01
  namespace: nginx
spec:
  ingressClassName: nginx
  rules:
    - host: www.a.com
      http:
        paths:
          - backend:
              service:
                name: nginx-svc
                port:
                  number: 80
            path: /
            pathType: Prefix
```
> 注意：
``绑定SVC使用``
``需要绑定域名``