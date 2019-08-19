---
title: Windows server 2008 开启端口
types: post
tags: ["others", "运维"]
date: 2019-07-01T03:50:35.000Z
category: 运维
published: true
---

<a name="7TRMy"></a>
# 1. 问题

<br />将项目部署到 Windows server 2008 服务器上，开启了 http/https 之后，在用服务器本身的浏览器访问：[http://domain.com]() ([https://domain.com](https://domain.com)) 就可以访问，可是在外用其他电脑就访问相同的 url 就不能够访问。<br />

<a name="gULFp"></a>
# 2. 原因

<br />造成以上问题，很大部分的原因在于服务器的防火墙限制了 80、443 对外的端口，也就是说没有开放这个端口给外部客户端访问。<br />

<a name="wywPX"></a>
# 3. 开启端口

windows server 2008 大多数端口都是默认关闭的，这里我们使用 httpd 的 80 端口为例，演示如何开启一个端口。

"**开始**" -> "**控制面板**" ->"**Windows 防火墙**" -> "**高级设置**" -> "**入站规则**"：

选择 "**Windows 防火墙**"：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557036858993-2d97356a-6df9-4026-b31c-f1a19628d03e.png#align=left&display=inline&height=431&name=image.png&originHeight=431&originWidth=722&size=38916&status=done&width=722)

选择"**高级设置**"：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557036806356-33a68ccf-13a6-4328-9ebc-3280fb5b0bf6.png#align=left&display=inline&height=431&name=image.png&originHeight=431&originWidth=722&size=43779&status=done&width=722)

选择 "入站规则" → "新建规则"：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557036673262-ce659a83-0eaa-4382-be28-4b2c3d7e8d2d.png#align=left&display=inline&height=487&name=image.png&originHeight=487&originWidth=719&size=55883&status=done&width=719)

点击端口：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557036949712-ee064673-9edc-463f-948d-aac021b42783.png#align=left&display=inline&height=529&name=image.png&originHeight=529&originWidth=720&size=24482&status=done&width=720)

添加 80 端口：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557037078099-4e0bd403-d601-4000-8d7e-28545c3483e1.png#align=left&display=inline&height=531&name=image.png&originHeight=531&originWidth=721&size=21813&status=done&width=721)

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557037108133-6a523e0c-9080-4ae9-8814-a94991e3233b.png#align=left&display=inline&height=532&name=image.png&originHeight=532&originWidth=719&size=25816&status=done&width=719)

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557037135819-a9ee5f84-8308-43aa-8fd1-04c947886879.png#align=left&display=inline&height=532&name=image.png&originHeight=532&originWidth=720&size=21584&status=done&width=720)

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1557037200758-2054ad84-6d48-43fc-b495-ca161bb01e8a.png#align=left&display=inline&height=529&name=image.png&originHeight=529&originWidth=721&size=17383&status=done&width=721)

这样我们就可以访问我们的主机 apache 服务了。
