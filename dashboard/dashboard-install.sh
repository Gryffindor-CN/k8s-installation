#!/bin/bash

# 安装dashboard
kubectl apply -f ./recommended.yaml
kubectl create -f ./dashboard-adminuser.yaml
echo -n '============获取dashboard后台登录秘钥============'
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

