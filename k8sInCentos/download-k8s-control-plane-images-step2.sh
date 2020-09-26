images=(kube-apiserver:v1.17.5 kube-controller-manager:v1.17.5 kube-scheduler:v1.17.5 kube-proxy:v1.17.5 pause:3.1 etcd:3.4.3-0 coredns:1.6.5)
echo $images
for imageName in ${images[@]};do echo $imageName; done
#for imageName in ${images[@]};do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; done
for imageName in ${images[@]};do docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName; docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName; done

