#! /bin/bash
# nfs 服务器地址
NFS_SERVER=192.168.206.23
# nfs 服务器存储路径
NFS_PATH=/data/redis/dev
# provisioner 名称
PROVISIONER_NAME=redis-dev-nfs
# 命名空间
NAMESPACE=lcv3-dev
# provisioner 配置文件
PROVISIONER_CONFIG_PATH=./redis-nfs-client.yaml
# pvc 配置文件
PVC_CONFIG_PATH=./redis-pvc.yaml
#
DEPLOYMENT_CONFIG_PATH=./redis-deployment.yaml

kubectl create namespace ${NAMESPACE} 

helm install stable/nfs-client-provisioner --set nfs.server=${NFS_SERVER} --set nfs.path=${NFS_PATH} --name ${PROVISIONER_NAME} --namespace ${NAMESPACE} -f ${PROVISIONER_CONFIG_PATH}

kubectl apply -f ${PVC_CONFIG_PATH}

kubectl apply -f ${DEPLOYMENT_CONFIG_PATH}