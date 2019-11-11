
#nfs服务端
#安装nfs-utils和rpcbind
yum install nfs-utils rpcbind -y
#添加开机启动
systemctl enable rpcbind && systemctl start rpcbind
systemctl enable nfs-server && systemctl start nfs-server

# 修改配置文件/etc/exports
# /data    *(rw,sync,no_subtree_check,no_root_squash)


#nfs客户端
#安装nfs-utils和rpcbind
#yum install nfs-utils rpcbind -y
#systemctl enable rpcbind
#测试
# showmount -e ip
