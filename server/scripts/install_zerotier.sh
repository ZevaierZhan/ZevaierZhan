#!/bin/bash

# 5. 安装zerotier
echo "安装zerotier..."
curl -s https://install.zerotier.com | sudo bash
sudo systemctl enable --now zerotier-one

echo "请执行以下命令加入网络:"
echo "sudo zerotier-cli join {network_id}"
echo "请替换 {network_id} 为你的 ZeroTier 网络 ID。"