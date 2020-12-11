#! /bin/sh
# install kubenetes on debian
# https://developer.aliyun.com/mirror/kubernetes
#
apt update
apt install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

apt update
#apt install -y kubelet kubeadm kubectl
apt-get install -y kubelet=1.19.3-00 kubeadm=1.19.3-00 kubectl=1.19.3-00
# show the version of kubenetes
kubeadm version
