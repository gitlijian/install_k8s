#!/bin/sh
# create a kubenetes cluster
#
# shutdown firewall on centos
#setenforce 0
#systemctl stop firewalld
# close swap
swapoff -a
# clear iptables
iptables -L
iptables --flush

# pull flannel
#docker pull quay.io/coreos/flannel:v0.13.0-amd64

# create a k8s cluster on a network "10.244.0.0/16"
kubeadm init --kubernetes-version=$(kubeadm version -o short) --pod-network-cidr="10.244.0.0/16"

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get nodes

kubectl apply -f kube-flannel.yml

