images=(kube-apiserver:v1.19.3 kube-controller-manager:v1.19.3 kube-scheduler:v1.19.3 kube-proxy:v1.19.3 pause:3.2 etcd:3.4.13-0 coredns:1.7.0)
echo $images
for imageName in ${images[@]};do echo $imageName; done
#for imageName in ${images[@]};do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; done
for imageName in ${images[@]};
	do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; 
	docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName; 
	docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName;
done


