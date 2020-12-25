---
title: 语雀图片与七牛云之间的迁移同步
type: post
tags: ["others", "开发"]
date: 2019-08-08T03:44:11.000Z
category: 开发
published: true
---

昨天登录 Github Jekyll 博客时候，忽然发现很多文章的图片都出现了 404！后来检查才知道，原来从 2019.08.07 起，语雀上的一些静态图片开启了防外链设置，因此之前通过 api 同步语雀文章的内容到第三方的平台，会导致包括图片在内的静态资源都无法访问。

于是乎，开始寻找解决方案，即通过七牛的镜像空间同步语雀的图片，然后渲染博客页面的时候将语雀域名转换为七牛上绑定的自定义域名，从而确保博客的图片都正常可用。关于七牛云镜像存储，这里列举两点介绍：

> 1. 七牛的镜像存储服务是一种快速的数据迁移和加速服务。可以帮助用户实现无缝数据迁移，迁移过程中并不影响原有业务系统的访问。镜像存储适用于迁移原有业务系统的已有数据。七牛提供分布式存储和加速分发服务，以分布式存储为核心服务。
> 1. 在镜像存储的业务模型里面，原来的图片或者视频访问域名将被配置为七牛的源站，而页面里面引用图片或视频链接的地方必须使用新的访问域名。然后将新的访问域名绑定 (CNAME) 到七牛空间对应的域名。在这些操作完成之后，终端用户就可以通过七牛访问图片或者视频等非结构化资源了。在每个访问请求到七牛的时候，如果七牛空间中不存在这个资源，那么七牛将主动回客户源站抓取资源并存储在空间里面，这样七牛就不需要再次回源客户的资源站点了。
> 
> 更详细的介绍，请参考七牛云官方文档：《[七牛镜像存储使用手册](https://developer.qiniu.com/kodo/kb/1376/seven-cattle-image-storage-instruction-manuals)》。



下面介绍一下具体的操作。

<a name="zxlMJ"></a>
## 一、注册，并新建对象存储的存储空间

七牛云注册，实名认证，这里不细说，很简单。新建对象存储的存储空间也很简单：<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565242056691-50655e8f-e816-441a-8247-758f47f90256.png#align=left&display=inline&height=496&name=image.png&originHeight=496&originWidth=1016&size=52609&status=done&width=1016)
<a name="3a9rq"></a>
## 二、增加镜像存储的镜像源

在创建好的对象存储空间（note-db）中，选择 "镜像存储"，添加语雀镜像源地址：<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565242263407-a2d8c1cd-ae81-476f-bc31-310e1087b1c5.png#align=left&display=inline&height=428&name=image.png&originHeight=428&originWidth=1037&size=40000&status=done&width=1037)

<a name="ZalRQ"></a>
## 三、绑定域名

七牛云绑定域名，并且设置 CNAME 的一个重要前提是：域名必须备案成功了才可以使用的！

简单说一下绑定了域名的作用：我们在七牛云上存储了图片文件什么的，访问地址都需要加上一个域名的。起初我们开通对象存储的时候，七牛云会给我们一个测试域名。但是测试域名会被收回，公告如下：<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565242719591-d4555868-0b16-4e55-98c2-39ce30758439.png#align=left&display=inline&height=198&name=image.png&originHeight=198&originWidth=596&size=26242&status=done&width=596)

所以我们需要用我们自己的二级域名来绑定七牛云进行访问（最好不用 www 开头的二级域名来绑定，因为 www 开头的域名，我们都是作为主域名的），具体绑定步骤如下。

<a name="pVkMh"></a>
### 3.1 绑定域名

![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565243055488-63b61899-032c-4eeb-84d4-a61eb45f0d0a.png#align=left&display=inline&height=371&name=image.png&originHeight=371&originWidth=1026&size=56497&status=done&width=1026)<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565243411951-6cccd7e7-2b8a-4c3c-81b8-1f8617bff7bc.png#align=left&display=inline&height=519&name=image.png&originHeight=519&originWidth=1046&size=66813&status=done&width=1046)

<a name="tt6ol"></a>
### 3.2 配置 CNAME

**首先**，上面 3.1 步骤，点击 "确认" 完成后，即可看到新增加域名的 CNAME 信息：<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565243547685-99f99f9c-3775-4c63-ad7d-cc04048bb9ef.png#align=left&display=inline&height=333&name=image.png&originHeight=333&originWidth=847&size=39662&status=done&width=847)

**第二步**，到你买域名的地方去配置。我是在阿里云上面买的，下面以阿里云为例：<br />**<br />**![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565244440370-93369291-54fb-4a27-b379-f6bd6743c121.png#align=left&display=inline&height=467&name=image.png&originHeight=467&originWidth=921&size=52928&status=done&width=921)**<br />**做到这一步就算已经完成了。成功之后，回到七牛云对象存储，在存储空间的概览也可以看到 CNAME 状态显示为"成功"：<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565244743676-bf39be2a-a794-49bc-9b40-f045082eb811.png#align=left&display=inline&height=254&name=image.png&originHeight=254&originWidth=1044&size=31709&status=done&width=1044)

**第三**，在博客中把博客所有 [http://qiniu.bioitee.com](http://qiniu.bioitee.com/) 的域名都替换成 [http://qiniu.bioinit.com](http://qiniu.bioinit.com/) 即可。

**第四**，如果想要换成 [http://qiniu.bioitee.com](http://qiniu.bioinit.com/)，需要在存储空间的 **"域名管理"** 中修改 https 配置。<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565245069990-880b4f8c-9530-4a20-a2c2-ff91dd68e6d7.png#align=left&display=inline&height=318&name=image.png&originHeight=318&originWidth=1191&size=46538&status=done&width=1191)

HTTPS 配置中的 SSL 证书可以选择申请七牛与的免费证书；也可以申请阿里云的** "免费型 DV SSL" **证书，然后选择本地上传 **"证书内容"** 和 **"证书私钥"**，我这里选择的是阿里云的** "免费型 DV SSL" **证书。<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565245903884-c498b8b9-7305-4413-afa6-c605853ed817.png#align=left&display=inline&height=344&name=image.png&originHeight=344&originWidth=1168&size=74764&status=done&width=1168)


<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565246118194-c1d76ebf-f8ae-4917-b37d-de0c159c8587.png#align=left&display=inline&height=283&name=image.png&originHeight=283&originWidth=636&size=29947&status=done&width=636)<br />
<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565245579390-7de4e039-e6e3-4f7a-bb9c-e4a015fb4472.png#align=left&display=inline&height=505&name=image.png&originHeight=505&originWidth=674&size=68177&status=done&width=674)

**"确认"** 提交后，等待大约 10 分钟，可以在七牛云对象存储空间的 **"域名管理"** → **"HPPTS 配置"** 看到 HTTPS 已经开启。<br />![image.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565246484060-358cc366-38c8-4e0e-95a4-81a937b623f0.png#align=left&display=inline&height=327&name=image.png&originHeight=327&originWidth=1208&size=48069&status=done&width=1208)

**最后**，在博客中把博客所有 [http://qiniu.bioitee.com](http://qiniu.bioitee.com/) 的域名都替换成 [http://qiniu.bioitee.com](http://qiniu.bioinit.com/)，并检查图片是否正常显示。


<a name="8lwWX"></a>
## 四、个人博客

参考 R 语言大神谢益辉（[https://yihui.name/](https://yihui.name/)）和 Jekyll 的一些大神，基于 Github Pages 搭建的 hugo+rblowndown、Jekyll 博客，附上首页截图，需要的请拿去。<br />![hugo.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565419585151-caacf476-acae-440c-b878-2d316fa9bc4a.png#align=left&display=inline&height=660&name=hugo.png&originHeight=660&originWidth=1049&size=121639&status=done&width=1049)

![jekyll_site.png](http://qiniu.bioitee.com/yuque/0/2019/png/126032/1565419489036-1407a79e-245c-4177-893f-ede837285416.png#align=left&display=inline&height=662&name=jekyll_site.png&originHeight=662&originWidth=1052&size=190642&status=done&width=1052)


