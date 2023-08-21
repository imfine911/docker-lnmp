#!/bin/sh
if [ $1 == 'start' ]; then
    sudo service docker start
    sleep 5
    echo "docker 服务 启动完成"
    cd /home/qiang/docker-lnmp && docker-compose up -d nginx
    echo "lnmp 服务 启动完成"
fi

if [ $1 == 'stop' ]; then
    cd /home/qiang/docker-lnmp && docker-compose down
    echo "lnmp 服务 关闭完成"
    sudo service docker stop
    echo "docker 服务 启动完成"
fi

if [ $1 == 'restart' ]; then
    cd /home/qiang/docker-lnmp && docker-compose down
    echo "lnmp 服务 关闭完成"
    docker-compose up -d nginx
    echo "lnmp 服务 启动完成"
fi



