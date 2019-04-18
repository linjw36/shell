#!/usr/bin/env bash
#
#
TE=$(date +%F" "%H:%M)
IP=$(ifconfig ens33 | awk -F" " 'NR==2{ print $2 }')
MAIL="example@mail.com"
TOTAL=$(free -m | awk -F" " 'NR==2{print $2}')
USE=$(free -m | awk -F" " 'NR==2{print $3}')
FREE=$(($TOTAL-$USE))
if [ $FREE -lt 1024 ];then
  echo "
  Date: $DATE
  Host: $IP
  Problem: Total=$TOTAL,Use=$USE,Free=$FREE
  " | mail -s "Memory Monitor" $MAIL
fi
