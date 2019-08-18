---
title: 手把手教你如何在 Linux 源码安装最新版本的 R
category: 运维
date: 2019-07-01T03:50:35.000Z
tags: 软件 R
published: true
---

如果你使用的 Linux 系统 GCC 版本太低，又没有 root 权限（即使有 root 权限又担心升级 GCC 带来的风险）；同时你又不想入坑 conda，但是你又希望安装一个最新版本的 R，那么恭喜你，这篇普通用户在 Linux（CentOS）下源码编译安装 R 的记录刚好满足了你想要的一切。

安装环境如下：

| 名称 | 版本 |
| :---: | --- |
| 系统 | Red Hat Enterprise Linux Server release 6.5 (Santiago), x86_64 |
| gcc | gcc version 4.4.7 20120313 (Red Hat 4.4.7-4) (GCC) |



<a name="6dc08beb"></a>
# 一、CentOS 安装 R-3.6.0

```bash
# Rpy：--enable-R-shlib
# download list：https://mirrors.ustc.edu.cn/CRAN/src/base/R-3/
$ wget https://mirrors.ustc.edu.cn/CRAN/src/base/R-3/R-3.6.0.tar.gz 
$ tar zxvf R-3.6.0.tar.gz
$ cd R-3.6.0
$ ./configure --prefix=/Bioinfo/SoftWare/R-3.6.0  --enable-R-shlib --enable-BLAS-shlib  --with-blas   --with-lapack

    报错：
    checking for zlib.h... yes
    checking if zlib version >= 1.2.5... no
    checking whether zlib support suffices... configure: error: zlib library and headers are required  
    ## 缺少zlib或者zlib版本过低, 要求 zlib 版本 >= 1.2.5 (Ribo log01 节点无法安装 zlib >= 1.2.8)
```

关于 R 相关的动态库：

- R 编译的过程中，必须选择 `--enable-R-shlib` 选项，将 R 编译成 lib 模式，在此模式下，会生成 `path-to-R/lib/libR.so` 库；
- 同时，确保同目录下 `libRblas.so`、`libRlapack.so` 两个链接库也被正确生成，这两个库默认会生成，如果没有，需要添加参数：`--enable-BLAS-shlib` `--with-blas` `--with-lapack`；
- 如果不编译生成 `libR.so`，在安装 rpy2（python 中的 R 语言接口模块） 时就无法正确编译。


<a name="c85c3849"></a>
# 二、各种库和依赖解决


<a name="zlib"></a>
## zlib

根据《[R Installation and Administration: A.1 Essential programs and libraries](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Essential-programs-and-libraries)》官方文档， `zlib` (version 1.2.5 or later)，至少需要 1.2.5 及以上版本。

```bash
# download list：http://www.zlib.net/fossils/
$ wget http://www.zlib.net/fossils/zlib-1.2.6.tar.gz
$ tar xvf zlib-1.2.6.tar.gz
$ cd zlib-1.2.6
$ ./configure --prefix=/Bioinfo/SoftWare/NewLibs/zlib-1.2.6
$ make && make install
```

**接着安装 R-3.6.0：**
```bash
$ cd ../R-3.6.0
$ ./configure --prefix=/Bioinfo/SoftWare/R-3.6.0  --enable-R-shlib LDFLAGS="-L/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/lib" CPPFLAGS="-I/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/include"

    报错：
    checking for zlib.h... yes
    checking if zlib version >= 1.2.5... yes
    checking whether zlib support suffices... yes
    checking mmap support for zlib... yes
    checking for BZ2_bzlibVersion in -lbz2... yes
    checking bzlib.h usability... yes
    checking bzlib.h presence... yes
    checking for bzlib.h... yes
    checking if bzip2 version >= 1.0.6... no
    checking whether bzip2 support suffices... configure: error: bzip2 library and headers are required
    ## zlib 版本已经符合要求，bzip2 版本要求 >= 1.0.6
```


<a name="8e1933ba"></a>
## bzip2 or libbz2

根据《[R Installation and Administration: A.1 Essential programs and libraries](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Essential-programs-and-libraries)》官方文档，`libbz2` (version 1.0.6 or later: called **bzip2-libs**/**bzip2-devel** or **libbz2-1.0**/**libbz2-dev** by some Linux distributions)，至少需要 1.0.6 及以上版本。
```bash
$ wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
$ tar zvxf bzip2-1.0.6.tar.gz
$ cd bzip2-1.0.6
$ make -f Makefile-libbz2_so
$ make clean
$ make
$ make install PREFIX=/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6
```

**重新安装 R-3.6.0：**
```bash
$ cd ../R-3.6.0
$ ./configure --prefix=/Bioinfo/SoftWare/R-3.6.0  --enable-R-shlib LDFLAGS="-L/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/lib -L/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/lib" CPPFLAGS="-I/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/include -I/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/include"

    报错：
    checking if bzip2 version >= 1.0.6... yes
    checking whether bzip2 support suffices... yes
    checking for lzma_version_number in -llzma... yes
    checking lzma.h usability... yes
    checking lzma.h presence... yes
    checking for lzma.h... yes
    checking if lzma version >= 5.0.3... yes
    checking for pcre_fullinfo in -lpcre... no
    checking whether PCRE support suffices... configure: error: pcre >= 8.10 library and headers are required
    ## 要求 pcre >= 8.10 (同时要求 pcre < 10.0, 否则再次安装 R-3.6.0 时报错)
    
    # 安装 pcre-8.12，configure 编译 R-3.6.0 时报错:
    checking for pcre/pcre.h... no
    checking if PCRE version >= 8.10, < 10.0 and has UTF-8 support... no
    checking whether PCRE support suffices... configure: error: pcre >= 8.10 library and headers are required
    # PCRE 安装需要 --enable-utf8，同时版本 >= 8.10 且 < 10.0
```


<a name="pcre"></a>
## pcre

在《[R Installation and Administration: A.1 Essential programs and libraries](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Essential-programs-and-libraries)》官方文档中要求，PCRE 版本最好在 8.32 及以上。

> CRE (version 8.32 or later, although versions 8.20–8.31 will be accepted with a deprecation warning) is required (or just its library and headers if packaged separately). Only the '8-bit' interface is used (and only that is built by default when installing from sources). PCRE must be built with UTF-8 support (not the default, and checked by `configure`) and support for Unicode properties is assumed by some R packages. JIT support (optionally available) is desirable for the best performance: support for this and Unicode properties can be checked at run-time by calling `pcre_config()`.


```bash
$ wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz --no-check-certificate
$ tar zvxf pcre-8.40.tar.gz
$ cd pcre-8.40
$ ./configure --prefix=/Bioinfo/SoftWare/NewLibs/pcre-8.40 --enable-utf8
$ make -j3 && make install
```

**注意：**R-3.4.2 要求 pcre 版本(>= 8.20, < 10.0)

**重新安装 R-3.6.0：**
```bash
$ cd ../R-3.6.0
$ ./configure --prefix=/Bioinfo/SoftWare/R-3.6.0  --enable-R-shlib LDFLAGS="-L/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/lib -L/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/lib -L/Bioinfo/SoftWare/NewLibs/pcre-8.40/lib" CPPFLAGS="-I/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/include -I/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/include -I/Bioinfo/SoftWare/NewLibs/pcre-8.40/include"

    报错：
    checking curl/curl.h usability... yes
    checking curl/curl.h presence... yes
    checking for curl/curl.h... yes
    checking if libcurl is version 7 and >= 7.28.0... no
    configure: error: libcurl >= 7.28.0 library and headers are required with support for https
    # 需要安装 curl >= 7.28.0
```


<a name="eaf997ff"></a>
## curl or libcurl

在《[R Installation and Administration: A.1 Essential programs and libraries](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Essential-programs-and-libraries)》要求，libcurl 大于或等于 7.22.0 版本。Library `libcurl` (version 7.22.0 or later) is required, with at least 7.28.0 being desirable.
```bash
$ wget https://curl.haxx.se/download/curl-7.64.1.tar.gz --no-check-certificate
$ tar zvxf curl-7.64.1.tar.gz
$ cd curl-7.64.1
$ ./configure --prefix=/Bioinfo/SoftWare/NewLibs/curl-7.64.1
$ make
$ make install
```

**重新安装 R-3.6.0：**
```bash
$ ./configure --prefix=/Bioinfo/SoftWare/R-3.6.0  --enable-R-shlib LDFLAGS="-L/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/lib -L/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/lib -L/Bioinfo/SoftWare/NewLibs/pcre-8.40/lib -L/Bioinfo/SoftWare/NewLibs/curl-7.64.1/lib" CPPFLAGS="-I/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/include -I/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/include -I/Bioinfo/SoftWare/NewLibs/pcre-8.40/include -I/Bioinfo/SoftWare/NewLibs/curl-7.64.1/include"

$ make 

    报错：
    /Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/lib/libbz2.a: could not read symbols: Bad value
    collect2: ld returned 1 exit status
    make[3]: *** [libR.so] Error 1
    make[3]: Leaving directory `/home/shenweiyan/inst/R-3.6.0/src/main'
    make[2]: *** [R] Error 2
    make[2]: Leaving directory `/home/shenweiyan/inst/R-3.6.0/src/main'
    make[1]: *** [R] Error 1
    make[1]: Leaving directory `/home/shenweiyan/inst/R-3.6.0/src'
    make: *** [R] Error 1
    # 需要使用64位元的方法重新编译 bzip2
```

重装 bzip2-1.0.6**，**如下所示，首先修改 bzip2-1.0.6 的 Makefile 文件：
```c
CC=gcc -fPIC
AR=ar
RANLIB=ranlib
LDFLAGS=

BIGFILES=-D_FILE_OFFSET_BITS=64
```

然后，重新编译 bzip2-1.0.6：
```bash
$ make clean
$ make
$ make install PREFIX=/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6
```


<a name="liblzma"></a>
## liblzma

在编译过程中发现："**configure: error: "liblzma library and headers are required"**"，需要安装 **xz**，对应主页：[https://tukaani.org/xz/](https://tukaani.org/xz/)，安装如下：
```shell
$ wget https://nchc.dl.sourceforge.net/project/lzmautils/xz-5.2.3.tar.gz
$ tar zvxf xz-5.2.3.tar.gz
$ cd xz-5.2.3/
$ ./configure --prefix=/Bioinfo/SoftWare/NewLibs/xz-5.2.3
$ make -j3
$ make install
```


<a name="libtiff"></a>
## libtiff

R shell 中使用 capabilities() 可以查看 R 已经编译支持的功能，对于画图可以增加下面几个参数，使 R 支持对应格式的图片保存，与此同时要确保对应库已经安装。
```bash
--with-cairo            use cairo (and pango) if available [yes]
--with-libpng           use libpng library (if available) [yes]
--with-jpeglib          use jpeglib library (if available) [yes]
--with-libtiff          use libtiff library (if available) [yes]
```


以 tiff 为例，需要安装 libtiff 库：
> The bitmapped graphics devices `jpeg()`, `png()` and `tiff()` need the appropriate headers and libraries installed: `jpeg` (version 6b or later, or `libjpeg-turbo`) or `libpng` (version 1.2.7 or later) and `zlib` or `libtiff`(versions 4.0.[5-10] have been tested) respectively.

```bash
$ wget ftp://download.osgeo.org/libtiff/tiff-4.0.9.zip
$ unzip tiff-4.0.9.zip
$ cd tiff-4.0.9
$ ./configure --prefix=/Bioinfo/SoftWare/NewLibs/tiff-4.0.9
$ make
$ make install
```

然后重新编译 R-3.6.0：
```bash
$ ./configure --prefix=/Bioinfo/SoftWare/R-3.6.0 --enable-R-shlib --with-libtiff LDFLAGS="-L/Bioinfo/SoftWare/NewLibs/tiff-4.0.9/lib" CPPFLAGS="-I/Bioinfo/SoftWare/NewLibs/tiff-4.0.9/include"
```

如果 tiff 无法使用，可以考虑在 ~/.bashrc 中添加 libtiff 库路径，然后重新再编译 R 。
```bash
export LD_LIBRARY_PATH=/Bioinfo/SoftWare/NewLibs/tiff-4.0.9/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/Bioinfo/SoftWare/NewLibs/tiff-4.0.9/lib/pkgconfig:$PKG_CONFIG_PATH
```


<a name="872f855c"></a>
## libjpeg and libpng16

R 安装完以后，使用 plot 进行画图，如果出现如下错误：
```r
> plot(1:0)
Error in (function (display = "", width, height, pointsize, gamma, bg,  :
  X11 module cannot be loaded
In addition: Warning message:
In (function (display = "", width, height, pointsize, gamma, bg,  :
  unable to load shared object '/Bioinfo/SoftWare/R-3.6.0/lib64/R/modules//R_X11.so':
  libjpeg.so.9: cannot open shared object file: No such file or directory
> quit()
Save workspace image? [y/n/c]: n
```

使用 **ldd** 命令如果看到 libjpeg.so.9、libpng16.so.16 not found，则可以考虑手动安装这两个包：
```bash
$ /Bioinfo/SoftWare/R-3.6.0/bin/R CMD ldd /Bioinfo/SoftWare/R-3.6.0/lib64/R/modules//R_X11.so
        linux-vdso.so.1 =>  (0x00007fff3c79b000)
        libtiff.so.5 => /Bioinfo/SoftWare/NewLibs/tiff-4.0.9/lib/libtiff.so.5 (0x00007f75369dc000)
        libjpeg.so.9 => not found
        libpng16.so.16 => not found
        libpangocairo-1.0.so.0 => /usr/lib64/libpangocairo-1.0.so.0 (0x00007f75367ba000)
        libpango-1.0.so.0 => /usr/lib64/libpango-1.0.so.0 (0x00007f753656e000)
        libgobject-2.0.so.0 => /lib64/libgobject-2.0.so.0 (0x00007f7536322000)
        ......
```

libjpeg.so.9、libpng16.so.16 安装步骤如下：
```bash
$ wget http://www.ijg.org/files/jpegsrc.v9c.tar.gz
$ tar zvxf jpegsrc.v9c.tar.gz
$ cd jpeg-9c
$ ./configure --prefix=/Bioinfo/SoftWare/NewLibs/jpeg-9c
$ make
$ make install

$ wget https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz
$ tar zvxf libpng-1.6.37.tar.gz
$ cd libpng-1.6.37
$ ./configure --prefix=/Bioinfo/SoftWare/NewLibs/libpng-1.6.37
$ make
$ make install
```

- [http://libjpeg.sourceforge.net/](http://libjpeg.sourceforge.net/)


<a name="514fe040"></a>
# 三、完整编译安装命令

如果使用了自定义安装的 gcc/c++ 进行编译，需要在 configure 时候使用 CC/CXX 进行指定，否则使用系统默认的 gcc/c++。由于 CentOS-6.5 默认的 gcc==4.4.7，该版本的 gcc 会导致 R>=3.5.0 编译出现各种错误，非 root 用户手动升级 gcc 可以参考：[https://www.yuque.com/shenweiyan/cookbook/r-centos-update-gcc](https://www.yuque.com/shenweiyan/cookbook/r-centos-update-gcc)。

```shell
# 粘贴到命令行时，请把 \ 去掉，连成一行命令再回车执行
$ ./configure --prefix=/Bioinfo/SoftWare/R-3.6.0 \
  CC=/Bioinfo/SoftWare/gcc-4.8.5/bin/gcc \
  CXX=/Bioinfo/SoftWare/gcc-4.8.5/bin/c++ \
  --enable-R-shlib --with-libtiff --with-libpng --with-jpeglib \
  LDFLAGS="-L/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/lib \
  -L/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/lib \ 
  -L/Bioinfo/SoftWare/NewLibs/pcre-8.40/lib \ 
  -L/Bioinfo/SoftWare/NewLibs/curl-7.64.1/lib \
  -L/Bioinfo/SoftWare/NewLibs/tiff-4.0.9/lib \
  -L/Bioinfo/SoftWare/NewLibs/jpeg-9c/lib \
  -L/Bioinfo/SoftWare/NewLibs/libpng-1.6.37/lib" \ 
  CPPFLAGS="-I/Bioinfo/SoftWare/NewLibs/zlib-1.2.6/include \ 
  -I/Bioinfo/SoftWare/NewLibs/bzip2-1.0.6/include \ 
  -I/Bioinfo/SoftWare/NewLibs/pcre-8.40/include \
  -I/Bioinfo/SoftWare/NewLibs/curl-7.64.1/include \
  -I/Bioinfo/SoftWare/NewLibs/tiff-4.0.9/include \
  -I/Bioinfo/SoftWare/NewLibs/jpeg-9c/include \
  -I/Bioinfo/SoftWare/NewLibs/libpng-1.6.37/include"

# configure 的所有配置信息，都会保存在 ./Makeconf 文件中

$ make
$ make install
```


<a name="63d567f6"></a>
# 四、设置环境变量

最后，把安装完成的 R 添加至环境变量：
```bash
export R_HOME=path-to-R
export R_LIBS=$R_HOME/lib64/R/library
export LD_LIBRARY_PATH=$R_HOME/lib:$LD_LIBRARY_PATH
export PATH=$R_HOME/bin:$PATH
```

- **R_LIBS** 的作用是 python 的 rpy2 调用安装的 R 包时，根据该变量寻找对应的包；
- **LD_LIBRARY_PATH** 则是相关动态依赖库需要查找的路径；
- 环境变量设置中比较容易漏掉的是 **PATH** 和 **LD_LIBRARY_PATH**，如果是用 root 安装，可能会没有问题，如果安装到个人目录下，不添加这两个变量的话，就无法正确寻找需要的动态链接库，如下：
```python
$ python
Python 2.7.14 (default, Mar  9 2018, 08:39:17)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-16)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import rpy2
>>> import rpy2.robjects as robjects
Error: package or namespace load failed for ‘stats’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/Bioinfo/SoftWare/R-3.6.0/lib64/R/library/stats/libs/stats.so':
  libRlapack.so: cannot open shared object file: No such file or directory
During startup - Warning message:
package ‘stats’ in options("defaultPackages") was not found
>>> robjects.r('library(splines)')
Error: package or namespace load failed for ‘splines’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/Bioinfo/SoftWare/R-3.6.0/lib64/R/library/stats/libs/stats.so':
  libRlapack.so: cannot open shared object file: No such file or directory
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/Bioinfo/SoftWare/Python-2.7.14/lib/python2.7/site-packages/rpy2/robjects/__init__.py", line 269, in __call__
    res = self.eval(p)
  File "/Bioinfo/SoftWare/Python-2.7.14/lib/python2.7/site-packages/rpy2/robjects/functions.py", line 170, in __call__
    return super(SignatureTranslatedFunction, self).__call__(*args, **kwargs)
  File "/Bioinfo/SoftWare/Python-2.7.14/lib/python2.7/site-packages/rpy2/robjects/functions.py", line 100, in __call__
    res = super(Function, self).__call__(*new_args, **new_kwargs)
rpy2.rinterface.RRuntimeError: Error: package or namespace load failed for ‘splines’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/Bioinfo/SoftWare/R-3.6.0/lib64/R/library/stats/libs/stats.so':
  libRlapack.so: cannot open shared object file: No such file or directory
```

```bash
$ ldd /Bioinfo/SoftWare/R-3.6.0/lib64/R/library/stats/libs/stats.so
        linux-vdso.so.1 =>  (0x00007fffd65ba000)
        libRlapack.so => not found
        libRblas.so => not found
        libgfortran.so.3 => /lib64/libgfortran.so.3 (0x00007fed38cbb000)
        libm.so.6 => /lib64/libm.so.6 (0x00007fed389b9000)
        libquadmath.so.0 => /lib64/libquadmath.so.0 (0x00007fed3877c000)
        libR.so => not found
        libgomp.so.1 => /lib64/libgomp.so.1 (0x00007fed38556000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fed38339000)
        libc.so.6 => /lib64/libc.so.6 (0x00007fed37f76000)
        libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fed37d60000)
        /lib64/ld-linux-x86-64.so.2 (0x00005561aa2c3000)
```

解决方法：
```bash
$ export LD_LIBRARY_PATH="/Bioinfo/SoftWare/R-3.6.0/lib64/R/lib:$LD_LIBRARY_PATH"

$ ldd /Bioinfo/SoftWare/R-3.5.0/lib64/R/library/stats/libs/stats.so
        linux-vdso.so.1 =>  (0x00007ffd0f3af000)
        libRlapack.so => /Bioinfo/SoftWare/R-3.6.0/lib64/R/lib/libRlapack.so (0x00007f6509c47000)
        libRblas.so => /Bioinfo/SoftWare/R-3.6.0/lib64/R/lib/libRblas.so (0x00007f6509a19000)
        libgfortran.so.3 => /lib64/libgfortran.so.3 (0x00007f65096ee000)
        libm.so.6 => /lib64/libm.so.6 (0x00007f65093ec000)
        libquadmath.so.0 => /lib64/libquadmath.so.0 (0x00007f65091af000)
        libR.so => /Bioinfo/SoftWare/R-3.6.0/lib64/R/lib/libR.so (0x00007f6508b81000)
        libgomp.so.1 => /lib64/libgomp.so.1 (0x00007f650895b000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f650873e000)
        libc.so.6 => /lib64/libc.so.6 (0x00007f650837b000)
        libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f6508165000)
        /lib64/ld-linux-x86-64.so.2 (0x000055583c2da000)
        libreadline.so.6 => /lib64/libreadline.so.6 (0x00007f6507f1e000)
        libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f6507cbc000)
        liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f6507a96000)
        libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f6507885000)
        libz.so.1 => /lib64/libz.so.1 (0x00007f650766f000)
        librt.so.1 => /lib64/librt.so.1 (0x00007f6507467000)
        libdl.so.2 => /lib64/libdl.so.2 (0x00007f6507262000)
        libtinfo.so.5 => /lib64/libtinfo.so.5 (0x00007f6507038000)
```


以上就是普通用户源码编译安装最新版本 R 的全部内容，总的一句话就是缺什么安装什么，从最基本的 gcc 编译器开始到 R 所需要的各种依赖库，直至最终安装完成。

<a name="3342f2dc"></a>
# 五、参考资料

- 不死不灭，《[R-3.3.1源码安装](http://kuxingseng2016.blog.51cto.com/1374617/1846326)》，51CTO
- R 官方文档，《[R Installation and Administration](https://cran.r-project.org/doc/manuals/r-release/R-admin.html)》

![默认标题_横版二维码_2019.06.01.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1559899789708-8643c293-0711-46d8-92b6-5cd94023175b.png#align=left&display=inline&height=500&name=%E9%BB%98%E8%AE%A4%E6%A0%87%E9%A2%98_%E6%A8%AA%E7%89%88%E4%BA%8C%E7%BB%B4%E7%A0%81_2019.06.01.png&originHeight=500&originWidth=900&size=67641&status=done&width=900#align=left&display=inline&height=500&originHeight=500&originWidth=900&status=done&width=900)
