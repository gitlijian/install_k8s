#sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get remove -y docker-*

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker

sudo docker version

cat > /etc/docker/daemon.json <<EOF 
{
	"exec-opts": ["native.cgroupdriver=systemd"],	
	"log-driver": "json-file",
	"log-opts": {"max-size": "100m" },
	"storage-driver": "overlay2", "storage-opts": ["overlay2.override_kernel_check=true" ]
}
EOF
