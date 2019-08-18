---
title: 一次"胆战心惊"的真实集群运维经历
category: 运维
date: 2019-07-12T23:02:05.000Z
tags: others
published: true
---

周五在安装一个用于 CNV 检测的软件 CNVnator 的时候，不小心修改了 /lib64/libc.so.6 文件，结果导致了整个系统所有命令基本都不可用：
```
[root@log01 lib64]# ls
ls: error while loading shared libraries: libc.so.6: cannot open shared object file: No such file or directory
[root@log01 lib64]# ls -l
ls: error while loading shared libraries: libc.so.6: cannot open shared object file: No such file or directory
[root@log01 lib64]#
```

情况更加糟糕的是，我所在的系统是整个公司集群的唯一登录节点，并且在使用 root 重命名了 libc.so.6（mv /lib64/libc.so.6 /lib64/libc.so.6.bak）后又作死的退出了 root 用户的登录，以致于所有的用户再也无法使用 su 、ssh 进行 root 切换把 /lib64/libc.so.6.bak 重新改回来！ 与此同时，整个集群的所有用户在退出登录后再也无法通过 ssh 重新登录，su、ssh、ln、ls、scp、mv 等基础命令也全部失效！！！

对于还没有退出集群登录的普通用户虽然可以通过下面的命令使 ln、ls 等生效，但始终无法从根本上解决问题。

```
export  LD_PRELOAD=/lib64/libc-2.12.so
```

> **关于 glibc：**
> 
> glibc 是 GNU 发布的 libc 库，即 c 运行库。glibc 是 linux 系统中最底层的 api，几乎其它任何运行库都会依赖于 glibc。glibc 除了封装 linux 操作系统所提供的系统服务外，它本身也提供了许多其它一些必要功能服务的实现。由于 glibc 囊括了几乎所有的 UNIX 通行的标准，可以想见其内容包罗万象。而就像其他的 UNIX 系统一样，其内含的档案群分散于系统的树状目录结构中，像一个支架一般撑起整个作业系统。在 GNU/Linux 系统中，其 C 函式库发展史点出了 GNU/Linux  演进的几个重要里程碑，用 glibc 作为系统的 C 函式库，是 GNU/Linux 演进的一个重要里程碑。


Linux 上的很多命令都是依赖 libc.so.6 的动态链接库，如果您不小心把它给删除了，基本上所有命令都不能使用了。由此可见 libc.so.6 的重要性。

网络上关于 libc.so.6 误删的解决文章有很多，总结起来不外乎 2 种：

- 还没有退出 root 登录
```
[root@localhost ~]# LD_PRELOAD=/lib64/libc-2.12.so ln -s /lib64/libc-2.12.so /lib64/libc.so.6
```

- 已经退出 root 登录：重装系统或者使用 Linux rescue 模式修复。

作为 HPC 整个集群的 log 节点，不到万不得已是不会轻易重装系统的，于是我们选择了使用 Linux rescue 模式修复，以下是一些记录。


<a name="3d85286d"></a>
## 1. U 盘启动盘制作

由于原来的 log 节点是 rhel-server-6.5-x86_64 的操作系统，所以我们需要制作与之相对应的启动 U 盘。

首先，要下载 rhel-server-6.5-x86_64 镜像。

- rhel-server-6.5-x86_64-boot.iso（U盘安装需要此镜像）<br />
MD5: 004a37b1b0269992a3b341b8f7c3a579<br />
SHA-256: 31116987fb9f5161cd7a7c907d9acc57f832135faf55bb328d032fa6574e3f93<br />
文件大小：255 MB
- rhel-server-6.5-x86_64-dvd.iso（系统安装介质）<br />
MD5: a84d4d9eddb36fb417832166cd10a4c2<br />
SHA-256: a51b90f3dd4585781293ea08adde60eeb9cfa94670943bd99e9c07f13a259539<br />
文件大小：3,675 MB

其次，将启动文件写入 u 盘。以 UltraISO 软碟通为例，打开 UltraISO 软件，菜单 “文件” 打开 rhel-server-6.5-x86_64-boot.iso ，菜单 “启动” ==> “写入硬盘映像”，弹出对话框，点击 “格式化”，格式化完成点击 “写入”。

最后，将安装光盘镜像 rhel-server-6.5-x86_64-dvd.iso  拷贝到 u 盘根目录。


<a name="fa4f50ef"></a>
## 2. Linux rescue模式

<a name="9c763011"></a>
### 2.1. 说明

Linux下用光盘进行 rescue 模式的方法，需要注意的是实体机跟虚拟机还是有很大差别的，在实体机中通过光盘启动，可能会自动进入到安装界面，所有我们需要在进入安装界面前（会提示 press any key 之类）快速按键盘上的按键（只有三秒钟需要关注。）

如果不理会就会进入以下界面：<br />![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531584-74fee520-6c7c-4783-9f32-32ccdcb40295.png#align=left&display=inline&height=591&originHeight=591&originWidth=794&size=0&status=done&width=794)


<a name="c8f0441e"></a>
### 2.2. rescue 模式步骤

1. 选择 rescue 模式<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531556-9cf2b06c-5166-40b0-92aa-de59e70ff603.png#align=left&display=inline&height=474&originHeight=474&originWidth=634&size=0&status=done&width=634)

2. 选择语言<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531590-28af51c6-044c-4a07-a38d-a824fcd4af4b.png#align=left&display=inline&height=402&originHeight=402&originWidth=720&size=0&status=done&width=720)

3. 选择键盘<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531542-39f10346-41f6-4784-9fc4-76f311ae7da4.png#align=left&display=inline&height=403&originHeight=403&originWidth=723&size=0&status=done&width=723)

4. 我们选择不启用网络，因为启用也没用。<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531568-4a080c21-88ed-428d-9012-94ffef2de3f8.png#align=left&display=inline&height=404&originHeight=404&originWidth=722&size=0&status=done&width=722)

5. 选择继续（continue）<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531588-436dee73-dacb-4a83-9420-e42340208097.png#align=left&display=inline&height=404&originHeight=404&originWidth=717&size=0&status=done&width=717)

6. 选择OK<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531583-cc3a57b3-2f00-429d-8032-a6cf6b042845.png#align=left&display=inline&height=400&originHeight=400&originWidth=721&size=0&status=done&width=721)<br />


![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531581-6f39a1c6-a252-4163-aee7-043f51f01098.png#align=left&display=inline&height=406&originHeight=406&originWidth=719&size=0&status=done&width=719)

7. 选择回车键，打开shell<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531728-197a6422-10a4-4760-8f46-65892f6395b9.png#align=left&display=inline&height=412&originHeight=412&originWidth=724&size=0&status=done&width=724)

8. 进入模式后，我们就可以进行命令行操作了，此时会把硬盘的文件系统挂载在 /mnt/sysimage 目录下，如果未挂载使用如下命令挂载:
```
chroot /mnt/sysimage
```

此时我们进入到 /mnt/sysimage，这里其实就是原系统的根目录，我们进行一些补救操作即可。<br />![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562972531590-f69460d9-bdd6-4c02-a7a0-84f9729077b2.png#align=left&display=inline&height=279&originHeight=279&originWidth=768&size=0&status=done&width=768)

9. 重启后重新进入系统一切正常。
9. 作为集群，需要重新执行一些必须的挂载、开启必要服务，在这里不详述。


<a name="393a3509"></a>
## 3. 总结

1. 对于系统的库文件，一定不要轻易去修改，特别是在使用 root 权限下。
1. HPC 软件安装最好使用非 root 进行安装，如 conda；对于必须要使用 root 安装的软件，应进一步评估该软件使用的必要性，同时应该明确每一步的文件改动所带来的后果。
1. 任何重要或不确定的文件改动请不要轻易执行删除，一定要先备份，以备出现故障后能尽快恢复。

最后，感谢美女领导，感谢运维的帅哥，感谢前华大运维的同事！！！
