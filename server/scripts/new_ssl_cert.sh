DIR=$(dirname $0)/../../tmp
cd $DIR
WORKDIR=$(pwd)

CA_CRT=$WORKDIR/ca.crt
CA_KEY=$WORKDIR/ca.key
IP=
if [ -z $1 ]; then
  read -p '请输入证书IP: ' IP
else
  IP=$1
fi
SUBJ=/C=CN/ST=Guangdong/L=Guangzhou/O=Zevaier/CN=$IP
DAYS=36500

# 生成私钥
openssl ecparam -genkey -name prime256v1 -out $WORKDIR/$IP.key

# 生成证书签名请求（CSR）
openssl req -new -key $WORKDIR/$IP.key -subj $SUBJ -out $WORKDIR/$IP.csr

# 创建扩展文件
echo "
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
IP = $IP
" > $WORKDIR/$IP.ext

# 使用CA签发服务器证书
openssl x509 -req -in $WORKDIR/$IP.csr -CA $CA_CRT -CAkey $CA_KEY -CAcreateserial -out $WORKDIR/$IP.crt -days $DAYS -sha256 -extfile $WORKDIR/$IP.ext
cat $CA_CRT >> $WORKDIR/$IP.crt

echo "已创建服务器$IP的SSL证书在$WORKDIR目录下."
