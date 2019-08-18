---
title: Python 中 tkinter 中文乱码
category: 软件
date: 2019-07-01T03:50:35.000Z
tags: others
published: true
---

<a name="2xvqwy"></a>
# [](#2xvqwy)引言

使用 Anaconda 3（conda 4.5.11）的 tkinter python 包（conda install -c conda-forge tk）开发 GUI 界面程序过程中，发现 UI 界面出现的中文 Unicode 乱码一直没办法解决。
```python
#-*- coding: utf-8 -*-

import sys

from tkinter import *
top=Tk()
top.wm_title("菜单")
top.geometry("800x600+300+100") # 创建一个菜单项，类似于导航栏
menubar=Menu(top) # 创建菜单项
fmenu1=Menu(top)
# 如果该菜单时顶层菜单的一个菜单项，则它添加的是下拉菜单的菜单
for item in ['新建文件', '打开文件','结果保存']:
    fmenu1.add_command(label=item)

fmenu2=Menu(top)
for item in ['程序设置','程序运行']:
    fmenu2.add_command(label=item)

fmenu3=Menu(top)
for item in ['使用教程', '版权信息', '检查更新']:
    fmenu3.add_command(label=item)

# add_cascade 的一个很重要的属性就是 menu 属性，它指明了要把那个菜单级联到该菜单项上
# 当然，还必不可少的就是 label 属性，用于指定该菜单项的名称
menubar.add_cascade(label='文件', menu=fmenu1)
menubar.add_cascade(label="程序", menu=fmenu2)
menubar.add_cascade(label="帮助", menu=fmenu3)

# 最后可以用窗口的 menu 属性指定我们使用哪一个作为它的顶层菜单
top['menu']=menubar
top.mainloop()
```

![](https://qiniu.bioinit.com/yuque/0/2018/png/126032/1542963148853-7093deb3-357e-4a7d-a42c-8e823a34443a.png#width=390)

- python3.x中文编码转换的问题，[https://bbs.bccn.net/thread-479560-1-1.html](https://bbs.bccn.net/thread-479560-1-1.html)

- Python 2.6 Tk 中文亂碼問題解決方法，[http://blogkrogh.blogspot.com/2011/03/python-26-tk.html](http://blogkrogh.blogspot.com/2011/03/python-26-tk.html)

- tkinter乱码，pyqt4乱码，[http://aboutweb.lofter.com/post/11743e_6f7e4a5](http://aboutweb.lofter.com/post/11743e_6f7e4a5)


上面几种方法测试后，问题依然存在。在 google 上一番搜索和来回测试之后，发现了几点信息：

1. 有人说，可能是 tcl/tk 安装不完整造成的。

2. tcl/tk 重装后需要对 Python 重新编译 tkinter 才能起作用。

3. conda install -c conda-forge tk，虽然没有任何报错，python 中 import tkinter 也正常，但 conda 的软件安装就像一个黑盒子，无法确认 tcl/tk 是否完整安装。

4. python 的 PyPI 仓库中是没有 tkinter 包的，想要使用 `pip install tkinter` 卸载或者重装都是行不通的。

5. 网上也有人说可以使用 `yum install python3-tk/python-tk` 解决，但对于本人来说，没用。



<a name="ut4hbn"></a>
# [](#ut4hbn)什么是 tcl, tk, tkinter

> The [tkinter](https://docs.python.org/3.6/library/tkinter.html#module-tkinter) package (“Tk interface”) is the standard Python interface to the Tk GUI toolkit. Both Tk and [tkinter](https://docs.python.org/3.6/library/tkinter.html#module-tkinter) are available on most Unix platforms, as well as on Windows systems. (Tk itself is not part of Python; it is maintained at ActiveState.)
> 
> Running `python -m tkinter` from the command line should open a window demonstrating a simple Tk interface, letting you know that [tkinter](https://docs.python.org/3.6/library/tkinter.html#module-tkinter) is properly installed on your system, and also showing what version of Tcl/Tk is installed, so you can read the Tcl/Tk documentation specific to that version.
> 
> From [https://docs.python.org/3/library/tkinter.html](https://docs.python.org/3/library/tkinter.html)


Tcl 是"工具控制语言（Tool Control Language）"的缩写。Tk 是 Tcl "图形工具箱" 的扩展，它提供各种标准的 GUI 接口项，以利于迅速进行高级应用程序开发。

tkinter 包（"Tk 接口"）是 Tk GUI 工具包的标准 Python 接口。 Tk 和 tkinter 在大多数 Unix 平台以及 Windows 系统上都可用（Tk 本身不是 Python 的一部分，它在 ActiveState 中维护）。您可以通过从命令行运行 `python -m tkinter`来检查 tkinter 是否已正确安装在系统上。如果已经安装该命令会打开一个简单的 Tk 界面，该界面除了让我们知道 tkinter 已正确安装，并且还显示安装了哪个版本的 Tcl/Tk，因此我们可以阅读特定于该版本的 Tcl/Tk 文档。

![](https://qiniu.bioinit.com/yuque/0/2018/png/126032/1543216747804-1a032456-97a6-40d5-a6d8-26df90208753.png#width=348)

如果 tkinter 没有安装，则会提示找不到该包（注意在 Python 2 中该包包名为 Tkinter，Python 3 中为 tkinter）：

![](https://qiniu.bioinit.com/yuque/0/2018/png/126032/1543216935547-c6324ffc-7042-4076-82a0-759565c4b258.png#width=687)

接下来我们将尝试在 Python 2 中安装 Tcl/Tk，并重新编译 python 2，已完成 Tkinter 安装（tkinter 为 Python 的标准库，标准库的安装需要重新编译 Python ?）。<br />

<a name="ia1frt"></a>
# [](#ia1frt)ActiveTcl 安装

ActiveTcl 是 ActiveState 发布的关于 Tcl/Tk 的发行版本，该发行版本包含了最新版本的 Tk 和 Tcl 程序，我们下载其免费的社区版本进行安装即可。

参考下载链接：[https://www.activestate.com/products/activetcl/downloads/](https://www.activestate.com/products/activetcl/downloads/)<br />参考安装教程：[https://tkdocs.com/tutorial/install.html](https://tkdocs.com/tutorial/install.html)<br />

以下为 CentOS 7 下 **ActiveTcl-8.6.8.0 **的一些安装记录，仅作参考。

```bash
$ wget https://downloads.activestate.com/ActiveTcl/releases/8.6.8.0/ActiveTcl-8.6.8.0-x86_64-linux-glibc-2.5.tar.gz
$ tar zvxf ActiveTcl-8.6.8.0-x86_64-linux-glibc-2.5.tar.gz
$ cd ActiveTcl-8.6.8.0-x86_64-linux-glibc-2.5-28eabcbe7
$ ./install.sh
Welcome to

  ActiveTcl Community Edition for Linux/x86_64

Supported Packages:

        Tcl     8.6     Thread  2.7.3
        Tk      8.6     trofs   0.4.9

Extra Packages:

 zlib 1.2.11
 libiconv 1.15

 ...

 Cancel => C
Next   => [RET] >> 【Enter 回车】

 ...

Cancel         [no]  => [RET]
Accept License [yes] => 'A' >> yes

Please specify the installation directory.
Path [/opt/ActiveTcl-8.6]: /usr/local/software/ActiveTcl-8.6

Please specify the directory for the demos.
Path [/usr/local/software/ActiveTcl-8.6/demos]: 【Enter 回车】

...

Installing ActiveTcl ...
Installing demos ...
Done ...
Finishing the installation
Patching the shells and libraries for the new location ...
* /usr/local/software/ActiveTcl-8.6/bin/tclsh8.6 ...
* /usr/local/software/ActiveTcl-8.6/bin/wish8.6 ...

...

For a csh or compatible perform
    setenv PATH "/usr/local/software/ActiveTcl-8.6/bin:$PATH"

For a sh or similar perform
    PATH="/usr/local/software/ActiveTcl-8.6/bin:$PATH"
    export PATH

Some shells (bash for example) allow
    export PATH="/usr/local/software/ActiveTcl-8.6/bin:$PATH"

Similar changes are required for MANPATH
Finish >>

Do you want to download a free trial of Komodo IDE? [Y/n]
```

ActiveTcl 安装完成后，需要把 path 添加至环境变量（~/.bashrc）:
```
export PATH="/usr/local/software/ActiveTcl-8.6/bin:$PATH"
```


<a name="h36qsw"></a>
# [](#h36qsw)Python 重新编译安装

想要在 Python 2.7 安装 Tkinter，需要在编译过程中通过 `--with-tcltk-includes` 和 `--with-tcltk-libs` 中指定 ActiveTcl 的头文件以及库所在路径。

如果在执行编译安装过程中，出现无法找到 libXss.so.1 共享动态库报错：

```bash
$ tar zvxf Python-2.7.15.tgz
$ cd Python-2.7.15
$ ./configure --prefix=/usr/local/software/python-2.7 --with-tcltk-includes='-I/usr/local/software/ActiveTcl-8.6/include' --with-tcltk-libs='/usr/local/software/ActiveTcl-8.6/lib/libtcl8.6.so /usr/local/software/ActiveTcl-8.6/lib/libtk8.6.so' --enable-optimizations
$ make

......

warning: building with the bundled copy of libffi is deprecated on this platform.  It will not be distributed with Python 3.7
*** WARNING: renaming "_tkinter" since importing it failed: libXss.so.1: cannot open shared object file: No such file or directory

Python build finished successfully!
The necessary bits to build these optional modules were not found:
_dbm                  _gdbm
To find the necessary bits, look in setup.py in detect_modules() for the module's name.

The following modules found by detect_modules() in setup.py, have been
built by the Makefile instead, as configured by the Setup files:
atexit                pwd                   time

Following modules built successfully but were removed because they could not be imported:
_tkinter

running build_scripts

......
```

CentOS 下请参考以下解决方法：

```
$ sudo yum install libXScrnSaver libXScrnSaver-devel
```


<a name="kxiufd"></a>
# [](#kxiufd)调用 Tkinter

Python 2 重新编译完后，执行 `python2 -m Tkinter` 显示 Tk 的 ui 界面，以及相应的 Tcl/Tk 版本。

![](https://qiniu.bioinit.com/yuque/0/2018/png/126032/1543220699215-2e7e0388-1f6e-46b2-b6ec-4688460a1d3d.png#width=516)

这时候，我们重新运行开头的 GUI 界面程序，可以看到中文已经正常显示：

![](https://qiniu.bioinit.com/yuque/0/2018/png/126032/1543220938974-7d71cd19-ca4a-433c-ae27-8557c98b75d2.png#width=418)

---


<a name="s3apxn"></a>
# [](#s3apxn)参考资料

- Download And Install Tcl: ActiveTcl，[https://www.activestate.com/products/activetcl/downloads/](https://www.activestate.com/products/activetcl/downloads/)

- Installing Tk，[https://tkdocs.com/tutorial/install.html](https://tkdocs.com/tutorial/install.html)

- Python下"No module named _tkinter"问题解决过程分析，[https://www.jianshu.com/p/0baa9657377f](https://www.jianshu.com/p/0baa9657377f)

- Python GUI编程(Tkinter)文件对话框，[https://my.oschina.net/u/2245781/blog/661533](https://my.oschina.net/u/2245781/blog/661533)


