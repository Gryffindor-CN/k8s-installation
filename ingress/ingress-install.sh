#!/bin/bash

# 安装ingress
kubectl apply -f ./mandatory.yaml
kubectl apply -f ./service-nodeport.yaml