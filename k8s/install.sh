#!/bin/bash

# keepalived+haproxy配置
./keepalived-haproxy.sh

# 部署HA master
./kube-ha.sh

# 重启keepalived和haproxy
systemctl stop keepalived
systemctl enable keepalived
systemctl start keepalived
systemctl stop haproxy
systemctl enable haproxy
systemctl start haproxy

# 安装cni插件(calico)
kubectl apply -f ./cni/calico.yaml

# 让你的master参与调度
# kubectl taint nodes --all node-role.kubernetes.io/master-

# 修改nodePort端口范围(每个节点都要)
# vi /etc/kubernetes/manifests/kube-apiserver.yaml
# 添加行 - --service-node-port-range=80-32767