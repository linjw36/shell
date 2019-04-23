#!/usr/bin/env bash

#安装编译环境
yum -y install gcc gcc-c++

#安装pcre软件包（使nginx支持http rewrite模块）
yum install -y pcre pcre-devel wget

#安装openssl-devel（使nginx支持ssl）
yum install -y openssl openssl-devel

#安装zlib
yum install -y openssl openssl-devel

#创建用户
useradd nginx
echo "123" | passwd --stdin nginx

#下载安装nginx的安装包
wget http://nginx.org/download/nginx-1.14.2.tar.gz
tar -xf nginx-1.14.2.tar.gz -C /usr/local/
cd /usr/local/nginx-1.14.2

#编译nginx
./configure  --group=nginx  --user=nginx  --prefix=/usr/local/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf  --error-log-path=/var/log/nginx/error.log  --http-log-path=/var/log/nginx/access.log  --http-client-body-temp-path=/tmp/nginx/client_body  --http-proxy-temp-path=/tmp/nginx/proxy  --http-fastcgi-temp-path=/tmp/nginx/fastcgi  --pid-path=/var/run/nginx.pid  --lock-path=/var/lock/nginx  --with-http_stub_status_module  --with-http_ssl_module  --with-http_gzip_static_module  --with-pcre

#生成脚本及配置文件
make
mkdir -p /tmp/nginx/client_body
#安装
make install

#启动nginx服务
cd /usr/sbin
./nginx
nginx -V
