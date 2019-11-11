#! /bin/bash

NODE_EXPORTER_PATH=./node-exporter.yaml

# nfs 服务器地址
NFS_SERVER=192.168.206.23
# nfs 服务器存储路径
NFS_PATH=/data/prometheus
# provisioner 名称
PROVISIONER_NAME=prometheus-nfs
# 命名空间
NAMESPACE=kube-system
# provisioner 配置文件
PROVISIONER_CONFIG_PATH=./prometheus/nfs-client.yaml
# pvc 配置文件
PVC_CONFIG_PATH=./prometheus/pvc.yaml

PROMETHEUS_RBAC_PATH=./prometheus/rbac-setup.yaml
PROMETHEUS_CONFIGMAP_PATH=./prometheus/configmap.yaml
PROMETHEUS_DEPLOY_PATH=./prometheus/prometheus.deploy.yml
PROMETHEUS_SVC_PATH=./prometheus/prometheus.svc.yml

kubectl create -f ${PROMETHEUS_RBAC_PATH}

kubectl create -f ${NODE_EXPORTER_PATH}

helm install stable/nfs-client-provisioner --set nfs.server=${NFS_SERVER} --set nfs.path=${NFS_PATH} --name ${PROVISIONER_NAME} --namespace ${NAMESPACE} -f ${PROVISIONER_CONFIG_PATH}

kubectl create -f ${PVC_CONFIG_PATH}

kubectl create -f ${PROMETHEUS_CONFIGMAP_PATH}

kubectl create -f ${PROMETHEUS_DEPLOY_PATH}

kubectl create -f ${PROMETHEUS_SVC_PATH}
