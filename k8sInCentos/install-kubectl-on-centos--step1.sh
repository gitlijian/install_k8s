#!/bin/sh

# 1. 配置iptables，使之能看到桥接
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# 2. 添加Kubernetes源
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

#[kubernetes]
#name=Kubernetes
#baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
#enabled=1
#gpgcheck=1
#repo_gpgcheck=1
#gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
#exclude=kubelet kubeadm kubectl
#EOF

# 3. 关闭selinux
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# 4. 安装启动Kubernetes
[ $# = 0 ] && version="1.17.5-00" || version=$1
sudo yum install -y kubelet-1.17.5-0
sudo yum install -y kubectl-1.17.5-0
sudo yum install -y kubeadm-1.17.5-0
sudo systemctl enable --now kubelet
