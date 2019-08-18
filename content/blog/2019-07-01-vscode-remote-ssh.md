---
title: VSCode 中利用 Remote SSH 连接远程服务器
category: 开发
date: 2019-07-01T03:50:35.000Z
tags: others
published: true
---

<a name="dN4EE"></a>
# 引言

北京时间 2019 年 5 月 3 日，在 PyCon 2019 大会上，[微软发布了 VS Code Remote](https://zhuanlan.zhihu.com/p/64505333)。这是一个用来实现远程开发的功能插件，对于许多使用 Windows 进行开发，但是需要将程序部署在服务器的用户来说，提供了非常大的便利。这些插件包括了：

- Remote - SSH
- Remote - Containers
- Remote - WSL

第一个是基于 SSH 的远程连接主机，第二个用于连接容器，第三个用于连接 WSL，也就是 Linux 子系统。在 **Remote - SSH** 插件的介绍中这样写到：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561514312290-30de4102-49ee-4f4d-9152-87106ddd9062.png#align=left&display=inline&height=710&name=image.png&originHeight=710&originWidth=902&size=113462&status=done&width=902)

简单翻译一下就是：
> Remote - SSH 扩展允许您使用任何带有 SSH 服务器的远程计算机作为开发环境。由于几乎每个桌面和服务器操作系统都有可配置的 SSH 服务器，因此该扩展可以在各种情况下大大简化开发。
> 您可以：
> - 在部署的同一操作系统上进行开发，或者使用比本地计算机更快更专业的硬件。
> - 在不同的远程开发环境之间快速切换，安全地进行更新，而不必担心影响本地计算机。
> - 从多台计算机或位置访问现有开发环境。
> - 调试运行在其他位置（如客户站点或云中）的应用程序。
> 
由于扩展程序直接在远程计算机上运行命令和其他扩展，因此本地计算机上不需要源代码即可获得这些好处。您可以打开远程计算机上的任何文件夹并使用它，就像文件夹在您自己的计算机上一样。


在本文中，将对于基本的 **Remote - SSH** 的使用简单地进行介绍。

<a name="6FyhA"></a>
# 安装 **Remote-SSH **相关插件

截止 2019.06.26，**Remote - SSH**（预览版）已经可以在 VSCode 稳定版本中下载和安装使用了。安装步骤如下。

打开安装好的 VSCode，然后在最左边的侧边栏中找到 Extensions 项，即扩展选项卡，并进入，然后再搜索窗口中输入：Remote - SSH（或者 ssh 关键字）。<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561516153368-2b8782eb-d03f-4b7e-b5d5-c3a45e6fc021.png#align=left&display=inline&height=288&name=image.png&originHeight=288&originWidth=383&size=32907&status=done&width=383)

找到所对应的插件之后，点击绿色的 "**Install(安装)**" 即可开始安装。稍等片刻，在安装完成之后，在侧边栏中会出现一个 **Remote-SSh** 选项卡，即表示安装成功。<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561516456947-44fb6d26-b473-45ed-a231-f9c4e7282142.png#align=left&display=inline&height=355&name=image.png&originHeight=355&originWidth=900&size=76197&status=done&width=900)


<a name="Al3Ez"></a>
# 利用 Remote-SSH 连接服务器

在安装完成之后，点击左侧的 Remote-SSH 选项卡，再将鼠标移向 CONNECTIONS 栏，点击出现的 configure：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561516964374-a400e38a-ac32-4d25-9451-ef6c45103adc.png#align=left&display=inline&height=349&name=image.png&originHeight=349&originWidth=380&size=21672&status=done&width=380)

在 Select SSH configuration file to edit 中，选择第一项即可，开始对里面的内容进行编辑：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561517026779-3526bbee-052c-42af-9e3c-c89622339e6f.png#align=left&display=inline&height=188&name=image.png&originHeight=188&originWidth=898&size=27761&status=done&width=898)

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561517263978-e070ec34-bc4e-40a1-8114-4405cbc537df.png#align=left&display=inline&height=339&name=image.png&originHeight=339&originWidth=1345&size=37343&status=done&width=1345)

在上图中为初始情况下的 .ssh 文件夹下的 config 文件中的内容，需要将其修改为所需要的内容，修改之后不要忘记保存（若 SSH 端口不是默认的 22，则还需加一行 Port）。

**注意：**VSCode 的这个远程连接的插件是基于 OpenSSH 的，因此在本机需要装有 OpenSSH 的客户端，在服务器上也要装有 OpenSSH 的服务端，并且密钥文件已经放置在服务器中，即需要在 `cmd` 中可以直接通过命令 `ssh IP_ADDRESS -l USERNAME -p PORT` （其中 IP_ADDRESS、USERNAME、PORT 要修改为所需变量）连接的情况下，才可以通过这个插件连接到服务器。如果前面的这些配置还没有完成，VSCode 会报出以下错误：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561517524359-8682d342-1607-4543-bf47-8693ab372baa.png#align=left&display=inline&height=232&name=image.png&originHeight=232&originWidth=460&size=21155&status=done&width=460)


<a name="sQPN4"></a>
## 1. 安装 OpenSSH 客户端

各个平台下 OpenSSH 客户端的安装参考 VSCode 官方文档《[Installing a supported SSH client](https://code.visualstudio.com/docs/remote/troubleshooting#_installing-a-supported-ssh-client)》一节的内容。这里以 windows 7 为例，官方推荐：Install [Git for Windows](https://git-scm.com/download/win) and select the **Use Git and optional Unix tools from the Command Prompt** option or manually add `C:\Program Files\Git\usr\bin` into your PATH.

首先，安装 [Git for Windows](https://git-scm.com/download/win)，安装过程中注意勾选 "**Use Git and optional Unix tools from the Command Prompt**"。<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561519247026-212868d6-7052-41a0-861d-ead39f57b525.png#align=left&display=inline&height=408&name=image.png&originHeight=408&originWidth=521&size=39774&status=done&width=521)<br />
<br />其次，git 安装完后， `bash` 、 `ssh` 、 `ssh-keygen` 等一些常用的 linux 命令工具都已经安装到 `C:\Program Files\Git\usr\bin` 下，我们需要把这个目录添加到 windows 的系统环境变量中（我的电脑→属性→高级系统设置→环境变量→path）。<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561520047226-6ec3bf53-032f-4a40-8b09-5df780b9ba74.png#align=left&display=inline&height=449&name=image.png&originHeight=449&originWidth=826&size=42526&status=done&width=826)

第三，在 DOC 中测试 ssh 连接到远程服务器成功！<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561531605290-1cb922c3-034a-409d-8521-e239bf97bd22.png#align=left&display=inline&height=331&name=image.png&originHeight=331&originWidth=667&size=48829&status=done&width=667)


<a name="47kkY"></a>
## 2. SSH KEY 配置

1. 创建本地机器的 ssh 公钥

```powershell
ssh-keygen -t rsa -b 4096
```

<br />    ![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561531815344-46d9589f-f0e6-4e8e-a7ba-f7b9f1e4f027.png#align=left&display=inline&height=443&name=image.png&originHeight=443&originWidth=632&size=47027&status=done&width=632)

2. 把本地公钥拷贝至远程服务器，windows 下执行命令如下：
```powershell
SET REMOTEHOST=your-user-name-on-host@host-fqdn-or-ip-goes-here

scp %USERPROFILE%\.ssh\id_rsa.pub %REMOTEHOST%:~/tmp.pub
ssh %REMOTEHOST% "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat ~/tmp.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && rm -f ~/tmp.pub"
```

3. 配置完成后，在 DOC 中再次执行 `ssh IP_ADDRESS -l USERNAME -p PORT` 命令，如果可以免密码登陆远程的服务器，说明配置成功。
3. 更多详细的 ssh key 设置，请参考官方文档：《[Remote Development Tips and Tricks](https://code.visualstudio.com/docs/remote/troubleshooting)》。


<a name="fLDES"></a>
## 3. 使用 Remote-SSH 连接远端服务器

回到 VSCode 中 Remote-SSH 选项卡，在 Select SSH configuration file to edit 中将 config 文件修改完成之后，"Ctrl+s" 保存可以看到，在下面出现了我们所配置的远程连接，这里显示的是我设置的名称："**GalaxyServer**"，即 Galaxy 在线生信分析平台的服务器，然后点击 "**GalaxyServer**" 右侧的连接按钮(图中箭头所指），便会弹出一个新的窗口，在新的窗口中选择打开文件夹，便可以看到，这个窗口中的打开的便是服务器中的文件了，接下来便可以访问服务器中的文件并远程修改了。<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561529798038-4c23bcc8-8968-4b8a-b790-968b9b7d27b2.png#align=left&display=inline&height=369&name=image.png&originHeight=369&originWidth=953&size=43759&status=done&width=953)

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561529960026-cbd0d4be-d78e-47f7-b8b2-2539b056890b.png#align=left&display=inline&height=407&name=image.png&originHeight=407&originWidth=1102&size=68653&status=done&width=1102)

更多详细的 Remote SSH 的说明与使用配置，参考官方文档：《[Remote Development using SSH](https://code.visualstudio.com/docs/remote/ssh)》。


<a name="BG9g6"></a>
## 4. 在 Remote-SSH 中使用终端

Remote SSH 还有个强大的功能，就是在添加了工作区文件夹后，可以直接在 VSCode 上使用终端，执行远程 Linux 的命令：<br />![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561532635070-1fd19919-eb97-4d97-80fc-69e745750fc7.png#align=left&display=inline&height=552&name=image.png&originHeight=552&originWidth=999&size=94788&status=done&width=999)


以上就是 Visual Studio Code 上关于 Remote SSH 插件的一些简单安装、配置和使用心得体验，喜欢使用 VSCode的童鞋可以去尝试一下。

![默认标题_横版二维码_2019.06.01.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1561531217448-24c005b5-9d54-4dbc-b50f-e8578cd85f81.png#align=left&display=inline&height=500&name=%E9%BB%98%E8%AE%A4%E6%A0%87%E9%A2%98_%E6%A8%AA%E7%89%88%E4%BA%8C%E7%BB%B4%E7%A0%81_2019.06.01.png&originHeight=500&originWidth=900&size=67641&status=done&width=900)
