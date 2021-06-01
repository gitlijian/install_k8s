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
images=(kube-apiserver:v1.19.3 kube-controller-manager:v1.19.3 kube-scheduler:v1.19.3 kube-proxy:v1.19.3 pause:3.2 etcd:3.4.13-0 coredns:1.7.0) # 这行报错，使用: bash 脚本.sh
echo $images
for imageName in ${images[@]};do echo $imageName; done
#for imageName in ${images[@]};do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; done
for imageName in ${images[@]};
	do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; 
	docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName; 
	docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName;
done


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

