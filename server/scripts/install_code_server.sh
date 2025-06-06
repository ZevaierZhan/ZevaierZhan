#!/bin/bash

USER=zevaier

# 4. 安装code-server
echo "安装code-server..."
curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server@$USER

echo "请修改 /home/$USER/.config/code-server/config.yaml 中的设置以满足你的需求。"
echo "重启 code-server 服务:"
echo "sudo systemctl restart code-server@$USER"
echo "访问地址: http://<your_server_ip>:8080"
echo "请确保防火墙允许访问 8080 端口。"
echo "如果启动失败，请检查日志文件以获取更多信息，路径为/home/$USER/.local/share/code-server/coder-logs/"
echo "安装完成！"
