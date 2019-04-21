
#!/usr/bin/env bash

#所需要的依赖
yum -y update
yum -y groupinstall "Development Tools"
yum -y install ncurses ncurses-devel bison libgcrypt perl make cmake net-tools

#在系统中添加运行mysqld进程的用户mysql
groupadd mysql
useradd -M -g mysql -s /sbin/nologin mysql


#解压mysql的安装包
tar xf mysqld-xzip.tar.xz -C /usr/local/
chown -R mysql:mysql /usr/local/mysqld/*

#提升MySQL命令为系统级别命令
echo "export PATH=$PATH:/usr/local/mysqld/mysql/bin" >>/etc/profile
source /etc/profile

#拷贝默认配置文件至/etc/my.cnf中
chown -R mysql.mysql /usr/local/mysqld/*
cd /usr/local/mysqld/mysql/mysql-test/include
mv /etc/{my.cnf,my.cnf.bak}
cp -f /root/my.cnf /etc/my.cnf

#修改配置文件/etc/my.cnf
iplast=$(ifconfig | awk -F" " 'NR==2{print $2}' | awk -F"." '{print $4}')
sed -ri s/"server_id = 11"/"server_id = $iplast"/ /etc/my.cnf

#设置mysql.socket软链接到mysql命令指定的目录中
ln -s /usr/local/mysqld/tmp/mysql.sock /tmp/mysql.sock
cp -f /usr/local/mysqld/mysql/support-files/mysql.server /usr/bin/mysql.service

#.配置mysqld服务的管理工具
cd /usr/local/mysqld/mysql/support-files
cp mysql.server /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on

#启动mysql服务
mysql.service start
mysql -uroot -p"BavDu..0411"
