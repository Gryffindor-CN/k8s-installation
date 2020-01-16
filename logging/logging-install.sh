#!/bin/bash

# nfs 服务器地址
NFS_SERVER=192.168.206.23
# nfs 服务器存储路径
NFS_PATH=/data/es
# provisioner 名称
PROVISIONER_NAME=es-nfs
# 命名空间
NAMESPACE=logging
# provisioner 配置文件
PROVISIONER_CONFIG_PATH=./es-nfs-client.yaml

#创建命名空间
kubectl create namespace logging

# 安装es
helm install stable/nfs-client-provisioner --set nfs.server=${NFS_SERVER} --set nfs.path=${NFS_PATH} --name ${PROVISIONER_NAME} --namespace ${NAMESPACE} -f ${PROVISIONER_CONFIG_PATH}
kubectl create -f es-pvc.yaml
kubectl create -f es-deployment.yaml
kubectl create -f es-svc.yaml

# 安装fluentd
kubectl create -f fluentd-configmap.yaml
kubectl create -f fluentd-daemonset.yaml

# 安装kibana
kubectl create -f kibana.yaml
kubectl create -f kibana-ingress.yaml

# 清除nfs-client-provisioner
# helm delete es-nfs --purge
