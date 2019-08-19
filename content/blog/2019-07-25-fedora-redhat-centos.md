---
title: Fedora Redhat Centos 有什么区别和关系？
types: post
tags: ["RedHat", "CentOS", "运维"]
date: 2019-07-25T01:29:15.000Z
category: 运维
published: true
---

这里对 Redhat/CentOS/Fedora 之间以及与其他 Linux 发行版关系做一个基本的介绍。给新手选择一个 Linux 发行版提供指导和帮助。

!(https://qiniu.bioinit.com/yuque/0/2019/png/126032/1564018188751-ddfd3568-4d40-4ccd-9220-0d05efdaa1c6.png#align=left&display=inline&height=764&originHeight=764&originWidth=593&size=0&status=done&width=593)<br />**Fedora**<br />Fedora是基于Linux的集最新自由开源软件于一体的操作系统。Fedora**始终允许任何人自由使用，修改和发布。**它由来自世界各地的人们在Fedora项目社区下共同合作而成。Fedora项目对外开放，欢迎任何人加入。Fedora项目就在您眼前，它**引领着自由、开源软件以及内容的前进。** 特点是常常引入创新性的技术，被视为"新技术的试验场"。版本升级很快（约6个月），每个版本的支持较短，约为13个月。Red Hat 公司为 Fedora Project 提供赞助。<br />最新正式版本为 2013-12-17 发布的 Fedora 20，代号是 Heisenbug。<br />目前支持版本：19 & 20<br />官方网站：[http://fedoraproject.org/](http://fedoraproject.org/)<br />中文论坛：[http://bbs.fedora-zh.org/](http://bbs.fedora-zh.org/)<br />中文邮件列表：[fedora-chinese](https://admin.fedoraproject.org/mailman/listinfo/chinese)

**RHEL/Red Hat Enterprise Linux**<br />Red Hat Enterprise Linux是Red Hat公司定位于企业级应用的**商业性质**的Linux发行版。提供付费的技术支持和更新支持。RHEL4细分为AS、ES和WS和Desktop版本。RHEL5开始产品分成了6类（见[维基](http://en.wikipedia.org/wiki/Red_Hat_Enterprise_Linux)）。红帽公司对企业版 LINUX 的每个版本提供 7 年的支持。<br />最新正式版本为 2013-11-22 发布的 RHEL 6.5。<br />RHEL 5 系列也在支持。目前最新正式版本为 RHEL 5.10。<br />RHEL 4 系列也仍支持，目前最新版本为 4.9。<br />官方网站：[http://www.redhat.com/](http://www.redhat.com/)

**CentOS/Community ENTerprise Operating System**<br />CENTOS 是一个服务器级别的Linux发行版。由社区重新编译Red Hat公开的SRPM，去除了Red Hat的商标，更换LOGO得到。<br />最新正式版本为 2013-12-01 发布的 CentOS 6.5，<br />版本 5 系列最新为 CentOS 5.10。<br />官方网站：[http://www.centos.org/](http://www.centos.org/)

以上三者均采用了RPM包管理机制，使用yum解决软件包依赖，这方面和Debian/Ubuntu 的deb/apt不同。三者默认的桌面环境均为GNOME。与Mandriva默认KDE不同。

三者差别不大，相比而言，Fedora最适合新手做桌面使用，CentOS 适合个人做服务器应用，RHEL 适合企业应用。

三者之间有一定的依赖关系。RHEL 可以视为 Fedora 的派生版，CentOS 本身基于 RHEL。另外还有一些 Linux 发行版是基于以上的发行版制作的，例如Oracle Linux、Scientific Linux 是基于 RHEL 的。
