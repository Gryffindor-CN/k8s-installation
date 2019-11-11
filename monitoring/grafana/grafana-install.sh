#!/bin/bash

# nfs 服务器地址
NFS_SERVER=192.168.206.23
# nfs 服务器存储路径
NFS_PATH=/data/grafana
# provisioner 名称
PROVISIONER_NAME=grafana-nfs
# 命名空间
NAMESPACE=kube-system
# provisioner 配置文件
PROVISIONER_CONFIG_PATH=./nfs-client.yaml

helm install stable/nfs-client-provisioner --set nfs.server=${NFS_SERVER} --set nfs.path=${NFS_PATH} --name ${PROVISIONER_NAME} --namespace ${NAMESPACE} -f ${PROVISIONER_CONFIG_PATH}

kubectl create -f pvc.yaml

kubectl create -f deploy.yaml

kubectl create -f ingress.yaml
