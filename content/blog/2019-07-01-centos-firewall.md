---
title: CentOS 7 防火墙开启常见端口命令
category: 运维
date: 2019-07-01T03:50:35.000Z
tags: CentOS
published: true
---

Centos7 默认安装了 firewalld，如果没有安装的话，则需要 YUM 命令安装；firewalld 真的用不习惯，与之前的 iptable 防火墙区别太大，但毕竟是未来主流讲究慢慢磨合它的设置规则。

<a name="4aaf5d24"></a>
## 安装 Firewall 命令
```shell
yum install firewalld firewalld-config
```

<a name="e49f88df"></a>
## Firewall 开启常见端口命令
```shell
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=21/tcp --permanent
firewall-cmd --zone=public --add-port=53/udp --permanent
```

<a name="96bfd945"></a>
## Firewall 关闭常见端口命令
```shell
firewall-cmd --zone=public --remove-port=80/tcp --permanent
firewall-cmd --zone=public --remove-port=443/tcp --permanent
firewall-cmd --zone=public --remove-port=22/tcp --permanent
firewall-cmd --zone=public --remove-port=21/tcp --permanent
firewall-cmd --zone=public --remove-port=53/udp --permanent
```

<a name="c9769260"></a>
## 批量添加区间端口
```shell
firewall-cmd --zone=public --add-port=4400-4600/udp --permanent
firewall-cmd --zone=public --add-port=4400-4600/tcp --permanent
```

<a name="d4b16b51"></a>
## 开启防火墙命令
```shell
systemctl start firewalld.service
```

<a name="3f64273c"></a>
## 重启防火墙命令
```shell
firewall-cmd --reload  或者   service firewalld restart
```

<a name="b9750533"></a>
## 查看端口列表
```shell
firewall-cmd --permanent --list-port
```

<a name="880fde70"></a>
## 禁用防火墙
```shell
systemctl stop firewalld
```

<a name="4b9f9f02"></a>
## 设置开机启动
```shell
systemctl enable firewalld
```

<a name="8070c2ee"></a>
## 停止并禁用开机启动
```shell
sytemctl disable firewalld
```

<a name="45d9d51f"></a>
## 查看防火墙状态
```shell
systemctl status firewalld    或者 firewall-cmd --state
```

