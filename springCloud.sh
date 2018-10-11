#!/bin/bash
# chkconfig:2345 10 90
# description:SpringCloud

export JAVA_HOME=/data/system/java/jdk1.8
source /etc/profile

APPLICATION_NAME=aa
SERVER_NAME=aa-server
APP_NAME=aa.jar
LOG_PATH=/data/application/$APPLICATION_NAME/server-app/$SERVER_NAME/logs
DES_PATH=/data/application/$APPLICATION_NAME/server-app/$SERVER_NAME/app

usage() {
    echo "Usage: sh springCloud.sh [start|stop|restart|status]"
    exit 1
}

is_exist(){
  pid=`ps -ef|grep $APP_NAME|grep -v grep|awk '{print $2}' `
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}

start(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is already running. pid=${pid} ."
  else
    nohup java -jar $DES_PATH/$APP_NAME >> $LOG_PATH/$SERVER_NAME.log 2>&1 &
    echo "${APP_NAME} service has been successful"
  fi
}

stop(){
  is_exist
  if [ $? -eq "0" ]; then
    kill -9 $pid
    echo "${APP_NAME} service ceased to succeed"
  else
    echo "${APP_NAME} is not running"
  fi
}

status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is running. Pid is ${pid}"
  else
    echo "${APP_NAME} is NOT running."
  fi
}


restart(){
  stop
  start
}

case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac
