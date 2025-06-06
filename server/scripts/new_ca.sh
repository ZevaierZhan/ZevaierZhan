#!/bin/bash

DIR=$(dirname "$0")/../../tmp
cd $DIR
WORKDIR=$(pwd)
echo $WORKDIR
SUBJ=/C=CN/ST=Guangdong/L=Guangzhou/O=Zevaier/CN=Zevaier
DAYS=36500

#set x

# 生成ECC私钥
openssl ecparam -genkey -name prime256v1 -out $WORKDIR/ca.key

# 创建证书签名请求（CSR）
openssl req -new -key $WORKDIR/ca.key -subj $SUBJ -out $WORKDIR/ca.csr

# 自签名证书
openssl x509 -req -days $DAYS -in $WORKDIR/ca.csr -signkey $WORKDIR/ca.key -out $WORKDIR/ca.crt

echo "已创建CA证书在$WORKDIR目录下."
