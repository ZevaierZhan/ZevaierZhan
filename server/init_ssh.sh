#!/bin/bash

SSH_PORT=10022
DISABLE_ROOT=true
NEW_USER=zevaier
PUB_PATH=https://raw.githubusercontent.com/ZevaierZhan/ZevaierZhan/main/server/$NEW_USER.pub

echo "修改SSH配置..."
sudo sed -i "s/^#Port 22/Port $SSH_PORT/" /etc/ssh/sshd_config
if [ "$DISABLE_ROOT" = "true" ]; then
    sudo sed -i "s/^PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
fi

# 2. 创建新用户
echo "创建新用户 $NEW_USER..."
sudo useradd -m -s /bin/bash $NEW_USER
sudo mkdir -p /home/$NEW_USER/.ssh
sudo chmod 700 /home/$NEW_USER/.ssh

# 3. 设置密钥认证
echo "设置密钥认证..."
wget -O /home/$NEW_USER/.ssh/authorized_keys $PUB_PATH
sudo chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh
sudo chmod 600 /home/$NEW_USER/.ssh/authorized_keys

# 4. 重启SSH服务
echo "请执行以下命令重启SSH服务:"
echo "sudo systemctl restart sshd"