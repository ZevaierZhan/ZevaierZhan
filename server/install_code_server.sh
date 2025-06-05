#!/bin/bash

NEW_USER=zevaier

# 4. 安装code-server
echo "安装code-server..."
curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server@$NEW_USER
