#!/bin/bash
# chkconfig:2345 10 90
# description:

APPLICATION_NAME=aa
SERVER_NAME=aa-server
APP_NAME=aa.jar
LOG_PATH=/data/application/$APPLICATION_NAME/server-app/$SERVER_NAME/logs
DES_PATH=/data/application/$APPLICATION_NAME/server-app/$SERVER_NAME/app
TMP_PATH=/data/application/$APPLICATION_NAME/server-app/$SERVER_NAME/tmp
BAK_PATH="/data/application/$APPLICATION_NAME/server-app/$SERVER_NAME/backup/`date +%Y%m%d-%H%M`"

export JAVA_HOME=/data/system/java/jdk1.8
source /etc/profile

PID=`ps -ef |grep $APP_NAME |grep -v "grep" |awk '{print $2}'`

if [ $PID ];then
   echo "$SERVER_NAME  is running and pid=$PID"
   kill -9 $PID
else
   echo "$SERVER_NAME service is a stop state"
fi

rm -rf /data/application/$APPLICATION_NAME/server-app/$SERVER_NAME/backup/*

mkdir -p $BAK_PATH;\cp -a $DES_PATH/* $BAK_PATH/

rm -rf $DES_PATH/*

cp -a $TMP_PATH/* $DES_PATH/

nohup java -jar  $DES_PATH/$APP_NAME  >> $LOG_PATH/$SERVER_NAME.log 2>&1 &


rm -rf $TMP_PATH/*

sleep 10

tail -n 300 $LOG_PATH/$SERVER_NAME.log
