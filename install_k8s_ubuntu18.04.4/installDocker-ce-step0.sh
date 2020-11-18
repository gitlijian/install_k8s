curl -sSL https://get.docker.com | sudo sh

# 设置 Docker 开机自启动
sudo systemctl enable docker
# 启动 Docker
sudo systemctl start docker
