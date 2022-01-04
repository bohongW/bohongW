#!/bin/bash

timedatectl set-timezone Asia/Shanghai && \
rpm -ivh http://mirrors.wlnmp.com/centos/wlnmp-release-centos.noarch.rpm && \
yum install -y wntp && \
ntpdate ntp.aliyun.com