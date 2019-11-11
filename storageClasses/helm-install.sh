#!/bin/bash

# 安装helm
curl -L https://git.io/get_helm.sh | bash

# 安装Helm的服务端tiller
kubectl create serviceaccount --namespace kube-system tiller  
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}' 

# helm install stable/nfs-client-provisioner --set nfs.server=192.168.150.55 --set nfs.path=/data/elasticsearch --name es-data-db --namespace logging -f ./nfs-client.yaml