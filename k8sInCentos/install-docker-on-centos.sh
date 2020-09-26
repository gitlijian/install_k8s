#!/bin/sh
# https://docs.docker.com/engine/install/centos/

# 0. 关闭防火墙，清iptables
sudo setenforce 0
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables -L
sudo iptables --flush

# 1. 首先去掉已有安装
sudo yum remove docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-engine

curl -sSL https://get.daocloud.io/docker | sh


sudo systemctl start docker  

cat > /etc/docker/daemon.json <<EOF 
{
	"exec-opts": ["native.cgroupdriver=systemd"],	
	"log-driver": "json-file",
	"log-opts": {"max-size": "100m" },
	"storage-driver": "overlay2", "storage-opts": ["overlay2.override_kernel_check=true" ]
}
EOF	
