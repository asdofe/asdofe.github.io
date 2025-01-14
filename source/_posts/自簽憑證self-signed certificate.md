---
title: 自簽憑證self-signed certificate
date: 2020-07-17 11:06:39
tags:
- linux
- 開發
---

# 流程

1. 產生根金鑰 (root key)
2. 產生根憑證 (root certificate)
3. 產生中繼金鑰 (key)
4. 產生中繼憑證請求 (csr)
5. 用根金鑰簽憑證
6. 把金鑰和憑證塞進https server並且重啟
7. 把根憑證匯入chrome

# 細節

* 跑完會產生6個檔案
	- ca.key
	- ca.crt
	- host.key
	- host.csr
	- host.crt
	- dn.conf
	- ssl.conf

一般來說ca.key和ca.crt保存起來用來產生下一次憑證，根憑證會上密碼

但為了產生方便下面的code沒有幫根憑證上密碼

如果有上密碼的會需要手動輸入4次密碼(ca.key產生的時候2次、ca.crt產生的時候1次和產生host.crt 1次)

而host.key和host.crt就是真正會被拿來餵server的憑證和鑰匙

記得改$DOMAINNAME設成自己的domain name
這個變數會填到[alt_names]底下的DNS.1
當然你用HOSTIP也是可以填一下

```sh
#!/bin/bash

set -e
TESTDIR=asdofetestselfsignedcertificate
if [ -d $TESTDIR ]
then
	echo "[Error] $TESTDIR already exists"
fi
mkdir $TESTDIR
cd $TESTDIR

CERTIFICATE_AUTHORITY_KEY_PATH=ca.key
CERTIFICATE_AUTHORITY_CRT_PATH=ca.crt
HOST_KEY_PATH=host.key
HOST_CSR_PATH=host.csr
HOST_CRT_PATH=host.crt
DN_CONF_PATH=dn.conf
CERTIFICATE_CONF_PATH=ssl.conf
DOMAINNAME=hellodomain.my
HOSTIP=192.168.0.1

## 產生根金鑰 (root key)
# 註解的部分是加密
# openssl genrsa -des3 -out $CERTIFICATE_AUTHORITY_KEY_PATH 2048
openssl genrsa -out $CERTIFICATE_AUTHORITY_KEY_PATH 2048

## 產生根憑證 (root certificate)
cat > $DN_CONF_PATH << EOF
[req]
distinguished_name = req_distinguished_name
prompt = no

[req_distinguished_name]
C = TW
ST = Taiwan
L = Taipei
O = HELLO Inc.
OU = HELLO Co., Ltd.
CN = HELLOCo., Ltd.
emailAddress=hello@hello.com
EOF

openssl req -x509 -new -nodes -key $CERTIFICATE_AUTHORITY_KEY_PATH -sha256 -days 3650 -config $DN_CONF_PATH -out $CERTIFICATE_AUTHORITY_CRT_PATH

## 產生中繼金鑰 (key)
openssl genrsa -out $HOST_KEY_PATH 2048

## 產生中繼憑證請求 (csr)
openssl req -new -key $HOST_KEY_PATH -out $HOST_CSR_PATH -config $DN_CONF_PATH

## 用根金鑰簽憑證
cat > $CERTIFICATE_CONF_PATH << EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE	
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $DOMAINNAME
IP.1 = $HOSTIP
EOF

openssl x509 -req -in $HOST_CSR_PATH -CA $CERTIFICATE_AUTHORITY_CRT_PATH -CAkey $CERTIFICATE_AUTHORITY_KEY_PATH -CAcreateserial \
-out $HOST_CRT_PATH -days 825 -sha256 -extfile $DN_CONF_PATH

echo '[Done]'

```


可以確認一下憑證上面的資料有沒有和預期不同
```sh
openssl x509 -in host.crt -text
```

把server設定檔設好重啟
再把host.crt匯入瀏覽器
https大功告成

* 參考資料: https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/