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
images=(kube-apiserver:v1.19.3 kube-controller-manager:v1.19.3 kube-scheduler:v1.19.3 kube-proxy:v1.19.3 pause:3.2 etcd:3.4.13-0 coredns:1.7.0)
echo $images
for imageName in ${images[@]};do echo $imageName; done
#for imageName in ${images[@]};do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; done
for imageName in ${images[@]};
	do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; 
	docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName; 
	docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName;
done


