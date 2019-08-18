---
title: Linux 下 Python 源码编译安装
category: 软件
date: 2019-05-18T12:10:10.000Z
tags: 软件 Python
published: true
---

基于 CentOS Linux release 6.5 源码编译安装 python-2.7.xx(Python-3.x.xx) 的一些步骤，以下为安装记录。

<a name="d635bbce"></a>
## 1. 安装环境

```bash
os : CentOS Linux release 6.5 (x86_64) 
gcc: 4.8.5 20150623
```


<a name="5590e8c9"></a>
## 2. 安装步骤

如果您拥有 root 权限，请执以下依赖安装：
```bash
yum install zlib
yum install zlib-devel
yum install openssl
yum install openssl-devel
yum install libffi
yum install libffi-devel
```

<a name="AVtPw"></a>
### 2.1 ssl

python3 需要引用 openssl 模块，但是 CentOS 需要的 openssl 版本最低为 1.0.2，而 CentOS 默认的为 1.0.1（Centos-6.x 通过 yum 源安装的 openssl 的最高版本是1.0.1），所以需要手动更新 openssl。
```bash
# 下载
wget http://www.openssl.org/source/openssl-1.1.1.tar.gz

# 解压缩
tar -zxvf openssl-1.1.1.tar.gz

# 进入目录安装
cd openssl-1.1.1

# 进行配置下，自定义
./config --prefix=$HOME/soft-repos/openssl shared zlib

# 编译并安装
make && make install

# 配置到用户环境变量，随处使用
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/soft-repos/openssl/lib" >> $HOME/.bashrc

# 是环境变量配置生效
source $HOME/.bashrc
```

**请注意：** 

1. **openssl** 编译（config）的时候 **必须要加上 shared 参数**，否者源码安装 Python 即使添加了 `--with-openssl` 的自定义路径，依然会导致 `Could not build the ssl module!` 报错！
1. 从 [https://www.openssl.org/source/](https://www.openssl.org/source/) 下载的源码 openssl-1.0.2s、openssl-1.0.2m 目前发现依然会导致 `Could not build the ssl module` ，建议从 [https://www.openssl.org/source/old/](https://www.openssl.org/source/old/) 下载 1.1.1 的源码编译安装。


<a name="MtwQq"></a>
### 2.2 ctypes

在 CentOS 6.x 安装 `libffi-devel` 的时候出现以下问题：
```bash
$ yum install -y libffi-devel
Loaded plugins: product-id, refresh-packagekit, search-disabled-repos, security, subscription-manager
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Setting up Install Process
cdrom                                                                                                                                         | 4.1 kB     00:00 ...
No package libffi-devel available.
Error: Nothing to do
```

可以使用下面的方法安装：
```shell
[root@log01 ~]# rpm -ivh http://mirror.centos.org/centos/6/os/x86_64/Packages/libffi-devel-3.0.5-3.2.el6.x86_64.rpm
Retrieving http://mirror.centos.org/centos/6/os/x86_64/Packages/libffi-devel-3.0.5-3.2.el6.x86_64.rpm
warning: /var/tmp/rpm-tmp.V9ihbu: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
   1:libffi-devel           ########################################### [100%]
[root@log01 ~]# rpm -qa|grep libffi
libffi-3.0.5-3.2.el6.x86_64
libffi-devel-3.0.5-3.2.el6.x86_64
```

源码方法安装如下：
```bash
$ wget ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
$ tar zvxf libffi-3.2.1.tar.gz
$ ./configure --prefix=/Bioinfo/Pipeline/SoftWare/LibDependence/libffi-3.2.1
$ make 
$ make install 
```


<a name="eE4JC"></a>
### 2.3 pygraphviz

```bash
$ /Bioinfo/Pipeline/SoftWare/Python-3.7.3/bin/pip3 install pygraphviz
Collecting pygraphviz
  Using cached https://files.pythonhosted.org/packages/7e/b1/d6d849ddaf6f11036f9980d433f383d4c13d1ebcfc3cd09bc845bda7e433/pygraphviz-1.5.zip
Installing collected packages: pygraphviz
  Running setup.py install for pygraphviz ... error
    Complete output from command /Bioinfo/Pipeline/SoftWare/Python-3.7.3/bin/python3.7 -u -c "import setuptools, tokenize;__file__='/tmp/pip-install-_zdjdg0j/pygraphviz/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-record-g0mz7lrq/install-record.txt --single-version-externally-managed --compile:
    running install
    Trying dpkg
    Failed to find dpkg
    Trying pkg-config
    Package libcgraph was not found in the pkg-config search path.
    Perhaps you should add the directory containing `libcgraph.pc'
    to the PKG_CONFIG_PATH environment variable
    No package 'libcgraph' found
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-install-_zdjdg0j/pygraphviz/setup.py", line 93, in <module>
        tests_require=['nose>=1.3.7', 'doctest-ignore-unicode>=0.1.2', 'mock>=2.0.0'],
      File "/Bioinfo/Pipeline/SoftWare/Python-3.7.3/lib/python3.7/site-packages/setuptools/__init__.py", line 145, in setup
        return distutils.core.setup(**attrs)
      File "/Bioinfo/Pipeline/SoftWare/Python-3.7.3/lib/python3.7/distutils/core.py", line 148, in setup
        dist.run_commands()
      File "/Bioinfo/Pipeline/SoftWare/Python-3.7.3/lib/python3.7/distutils/dist.py", line 966, in run_commands
        self.run_command(cmd)
      File "/Bioinfo/Pipeline/SoftWare/Python-3.7.3/lib/python3.7/distutils/dist.py", line 985, in run_command
        cmd_obj.run()
      File "/tmp/pip-install-_zdjdg0j/pygraphviz/setup_commands.py", line 44, in modified_run
        self.include_path, self.library_path = get_graphviz_dirs()
      File "/tmp/pip-install-_zdjdg0j/pygraphviz/setup_extra.py", line 162, in get_graphviz_dirs
        include_dirs, library_dirs = _try_configure(include_dirs, library_dirs, _pkg_config)
      File "/tmp/pip-install-_zdjdg0j/pygraphviz/setup_extra.py", line 117, in _try_configure
        i, l = try_function()
      File "/tmp/pip-install-_zdjdg0j/pygraphviz/setup_extra.py", line 72, in _pkg_config
        output = S.check_output(['pkg-config', '--libs-only-L', 'libcgraph'])
      File "/Bioinfo/Pipeline/SoftWare/Python-3.7.3/lib/python3.7/subprocess.py", line 395, in check_output
        **kwargs).stdout
      File "/Bioinfo/Pipeline/SoftWare/Python-3.7.3/lib/python3.7/subprocess.py", line 487, in run
        output=stdout, stderr=stderr)
    subprocess.CalledProcessError: Command '['pkg-config', '--libs-only-L', 'libcgraph']' returned non-zero exit status 1.

    ----------------------------------------
Command "/Bioinfo/Pipeline/SoftWare/Python-3.7.3/bin/python3.7 -u -c "import setuptools, tokenize;__file__='/tmp/pip-install-_zdjdg0j/pygraphviz/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-record-g0mz7lrq/install-record.txt --single-version-externally-managed --compile" failed with error code 1 in /tmp/pip-install-_zdjdg0j/pygraphviz/

```

参考：《[Installation:fatal error: 'graphviz/cgraph.h' file not found](https://github.com/pygraphviz/pygraphviz/issues/11)》
```bash
$ wget https://graphviz.gitlab.io/pub/graphviz/stable/SOURCES/graphviz.tar.gz
$ tar zvxf graphviz.tar.gz
$ cd graphviz-2.40.1
$ ./configure --prefix=/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1
$ make && make install
```

推荐把安装好的 graphviz 添加到环境变量，这样可以避免运行过程中出现："**pygraphviz/graphviz_wrap.c:2987:29: fatal error: graphviz/cgraph.h: No such file or directory" **无法找到头文件的异常。
```bash
export PKG_CONFIG_PATH=/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/include:$CPLUS_INCLUDE_PATH
```


如果 graphviz 添加到环境变量， `pygraphviz` 的 python 包可以参考下面的方法安装：
```bash
$ /Bioinfo/Pipeline/SoftWare/Python-3.7.3/bin/pip3 install --global-option=build_ext --global-option="-I/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/include" --global-option="-L/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/lib" pygraphviz
/Bioinfo/Pipeline/SoftWare/Python-3.7.3/lib/python3.7/site-packages/pip/_internal/commands/install.py:207: UserWarning: Disabling all use of wheels due to the use of --build-options / --global-options / --install-options.
  cmdoptions.check_install_build_global(options)
Collecting pygraphviz
  Using cached https://files.pythonhosted.org/packages/7e/b1/d6d849ddaf6f11036f9980d433f383d4c13d1ebcfc3cd09bc845bda7e433/pygraphviz-1.5.zip
Installing collected packages: pygraphviz
  Running setup.py install for pygraphviz ... done
Successfully installed pygraphviz-1.5
```


<a name="uB8Mi"></a>
### 2.4 编译安装

第一，下载 Python 源码，解压。
```bash
# 官网下载地址 https://www.python.org/downloads
wget https://www.python.org/ftp/python/2.7.15/Python-2.7.15.tgz
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz

# 解压到指定目录 
tar zvxf Python-3.7.3.tgz -C /usr/local/src
```

第二，进入解压的源码路径，编译 python 源码。
```bash
export PKG_CONFIG_PATH=/Bioinfo/Pipeline/SoftWare/LibDependence/libffi-3.2.1/lib/pkgconfig:/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/Bioinfo/Pipeline/SoftWare/LibDependence/libffi-3.2.1/lib64:/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/lib:$LD_LIBRARY_PATH

$ ./configure \
--enable-optimizations \
--prefix=/Bioinfo/Pipeline/SoftWare/Python-3.7.3 \
--with-openssl=/Bioinfo/Pipeline/SoftWare/LibDependence/openssl-1.1.1 \
CC=/Bioinfo/Pipeline/SoftWare/gcc-4.8.5/bin/gcc \
CXX=/RiboBio/Bioinfo/Pipeline/SoftWare/gcc-4.8.5/bin/c++ \
LDFLAGS="-L/Bioinfo/Pipeline/SoftWare/LibDependence/libffi-3.2.1/lib64 -L/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/lib" \
CPPFLAGS="-I/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/include" \
PKG_CONFIG_PATH="/Bioinfo/Pipeline/SoftWare/LibDependence/libffi-3.2.1/lib/pkgconfig:/Bioinfo/Pipeline/SoftWare/graphviz-2.40.1/lib/pkgconfig" 
```

- `--enable-optimizations` 是优化选项（LTO,PGO 等）加上这个 flag 编译后，性能有 10% 左右的优化，但是这会明显的增加编译时间。建议使用这个参数；
- `--prefix`  声明安装路径；
- 安装多个 python 的版本，如果不开启 `--enable-shared`，指定不同路径即可。当开启 `--enable-shared` 时，默认只有一个版本的 python。
- python 3 编译可以使用 `--with-openssl=DIR` 指定 OpenSSL 安装路径进行编译的方式解决 OpenSSL 依赖，否则 `make` 过程可能出错。 
```shell
$ make 
......
The following modules found by detect_modules() in setup.py, have been
built by the Makefile instead, as configured by the Setup files:
_abc                  atexit                pwd
time


Failed to build these modules:
_ctypes               _hashlib              _ssl


Could not build the ssl module!
Python requires an OpenSSL 1.0.2 or 1.1 compatible libssl with X509_VERIFY_PARAM_set1_host().
LibreSSL 2.6.4 and earlier do not provide the necessary APIs, https://github.com/libressl-portable/portable/issues/381

......
```

- `make` 过程如果出现 `ModuleNotFoundError: No module named '_ctypes'` 或者 `INFO: Could not locate ffi libs and/or headers` 参考：[https://groups.google.com/forum/#!topic/comp.lang.python/npv-wzmytzo](https://groups.google.com/forum/#!topic/comp.lang.python/npv-wzmytzo)

![image.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1562923411627-eb429b96-2ec8-408e-abbb-05f4e8a320f8.png#align=left&display=inline&height=316&name=image.png&originHeight=316&originWidth=581&size=34010&status=done&width=581)

- 如果指定 `--with-openssl=DIR` 依然无法解决 ssl 模块的问题，可以参考修改 Modules/Setup.dist 文件（默认这块是注释的，放开注释即可。这块功能是开启 SSL 模块，不然会出现安装完毕后，提示找不到 ssl 模块的错误）再执行 configure，修改内容如下：
```bash
# Socket module helper for SSL support; you must comment out the other
# socket line above, and possibly edit the SSL variable:
SSL=/usr/local/ssl
_ssl _ssl.c \
    -DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \
    -L$(SSL)/lib -lssl -lcrypto
```


第三，Makefile 生后依次在当前路径执行编译和安装命令。
```bash
make && make install
```

第四，安装完成。以上命令执行完毕，且无报错的情况下，我们将默认 python 换将切换至 3.7.xx/2.7.xx（一般不建议替换，个人建议把自定义安装的 Python bin 路径添加到 PATH 环境变量即可）：
```bash
# 替换系统自带的 python（不建议）
mv /usr/bin/python /usr/bin/python2
ln -s /Bioinfo/Pipeline/SoftWare/Python-3.7.3/bin/python3 /usr/bin/python

# 添加新 Python 到 PATH 环境变量（建议）
echo "export PATH=/Bioinfo/Pipeline/SoftWare/Python-3.7.3/bin:$PATH" >>~/.bashrc
source ~/.bashrc
```

运行命令 `python -V` ，查看是否出现 3.7.xx（2.7.xx）的版本，出现即为安装成功。


<a name="b9acf683"></a>
## 3. 安装 pip+setuptools

```bash
# 下载 setuptools 和 pip 安装程序
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```

至此，python 全部安装完成。


<a name="a6a2ae93"></a>
## 4. 参考资料

1. 行者无疆-ITer,《[python2.7源码编译安装](https://www.cnblogs.com/ITer-jack/p/8305912.html)》, 博客园
1. Scott Frazer,《[How do I compile Python 3.4 with custom OpenSSL?](https://stackoverflow.com/questions/23548188/how-do-i-compile-python-3-4-with-custom-openssl)》, Stack Overflow
