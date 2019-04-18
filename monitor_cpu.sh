#!/usr/bin/env bash

DATE=$(date +%F" "%H:%M)
IP=$(ifconfig ens33 | awk -F" " 'NR==2{ print $2 }')
MAIL="example@mail.com"
if [ ! -f /usr/bin/vmstat ];then
  echo "vmstat command no found,please install procps package"
  exit
fi
US=$(vmstat | awk 'NR==3{print $13}')
SY=$(vmstat | awk 'NR==3{print $14}')
ID=$(vmstat | awk 'NR==3{print $15}')
WA=$(vmstat | awk 'NR==3{print $16}')
USE=$(($US+$SY))
if [ $USE -ge 50 ];then
   echo "
   Date:$DATE
   Host:$IP
   Problem: CPU utilization $USE
   " | mail -s "CPU Monotor" $MAIL
fi
