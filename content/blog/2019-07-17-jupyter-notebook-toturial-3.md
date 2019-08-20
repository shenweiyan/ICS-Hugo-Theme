---
title: 数据科学工具 Jupyter Notebook 教程(三)
type: post
tags: ["Jupyter", "开发"]
date: 2019-07-17T08:25:34.000Z
category: 开发
published: true
---

<a name="df368884"></a>
## 前言

Jupyter Notebook 作为一个把代码、图像、注释、公式和作图集于一处，从而实现可读性分析的交互式笔记本工具，借助所谓的内核（Kernel）的概念，Jupyter Notebook 可以同时支持包括 python2、python3、R、Ruby 在内超过50多种不同编程环境。基于Kernel，Jupyter Notebook 可以支持的编程语言可以参考[列表](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)。


<a name="d994d598"></a>
## 目的

在 Jupyter Notebook 中实现 python2 与 python3 自由切换。


<a name="52b36576"></a>
## 步骤

参考：[https://stackoverflow.com/questions/30492623/using-both-python-2-x-and-python-3-x-in-ipython-notebook](https://stackoverflow.com/questions/30492623/using-both-python-2-x-and-python-3-x-in-ipython-notebook)

> The idea here is to install multiple `ipython` kernels. Here are instructions for anaconda. If you are not using anaconda, I recently added [instructions](https://stackoverflow.com/a/34464003/2272172) using pure virtualenvs.
> 
> **Anaconda 4.1.0**
> 
> Since version 4.1.0, anaconda includes a special package `nb_conda_kernels` that detects conda environments with notebook kernels and automatically registers them. This makes using a new python version as easy as creating new conda environments:

```bash
conda create -n py27 python=2.7 ipykernel
conda create -n py36 python=3.6 ipykernel
```

> After a restart of jupyter notebook, the new kernels are available over the graphical interface. Please note that new packages have to be explicitly installed into the new enviroments. The Managing environments section in conda's docs provides further information.


> **Manually registering kernels**
> 
> Users who do not want to use nb_conda_kernels or still use older versions of anaconda can use the following steps to manually register ipython kernels.
> 
> configure the `python2.7` environment:

```bash
conda create -n py27 python=2.7
source activate py27
conda install notebook ipykernel
ipython kernel install --user
```

> Additionally you can pass the `--name` and `--display-name` options to ipython kernel install if you want to change the names of your kernels. See `ipython kernel install --help` for more informations.


总结起来就是：

1. 在 python2 和 python3 环境中分别安装 ipykernel。
1. 手动为当前用户(--user)，或者指定路径(--prefix)安装 IPython kernel spec。

需要注意的是：

- 其中 `--user` 与 `--prefix` 不能同时使用。
- `--user` ，IPython kernel spec 默认安装到当前用户 **~/.local/share/jupyter/kernels** 或者 **~/.ipython/kernels**。
- 不加 `--user` 和 `--prefix` ，IPython kernel spec 默认安装到 **/usr/local/share/jupyter/kernels** 或者 **/usr/share/jupyter/kernels**。
- IPython kernel spec 安装可以使用 `python -m ipykernel install` ，也可以使用 `ipython-kernel-install`  命令，两者是一样的。<br />
![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563351954924-9deae7b8-600e-423f-9fce-497337ef6696.png#align=left&display=inline&height=388&originHeight=388&originWidth=626&size=0&status=done&width=626)


<a name="jvb8U"></a>
## 实战

使用 `--prefix` 指定 IPython kernel spec 安装路径：
```
# python2 环境（默认）
$ python -m pip install ipykernel
$ python -m ipykernel install --prefix=/Bio/Anaconda2.5/

# python3 环境
$ /Bio/Anaconda2.5/envs/python3/bin/python -m pip install ipykernel
$ /Bio/Anaconda2.5/envs/python3/bin/python -m ipykernel install --prefix=/Bio/Anaconda2.5/ --name "python3"
```

也可以使用 conda 进行安装：
```
# python2 环境（root）
conda install -n root ipykernel
python -m ipykernel install --prefix=/path/to/install --name "python2"

# python3 环境
conda install -n python3 ipykernel
/path/to/python3 -m ipykernel install --prefix=/path/to/install --name "python3"
```

最后，`jupyter-kernelspec list` 检查安装好的 kernels，启动 `jupyter notebook`。
```
$ jupyter-kernelspec list
Available kernels:
  python2    /Bio/Anaconda2.5/share/jupyter/kernels/python2
  python3    /Bio/Anaconda2.5/share/jupyter/kernels/python3
```

![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563351954918-bad06ed0-2a67-494a-84a5-0a9e07a064be.png#align=left&display=inline&height=326&originHeight=326&originWidth=596&size=0&status=done&width=596)

1. 在 python2 和 python3 环境中分别安装 ipykernel。
1. 手动为当前用户( `--user`  )，或者指定路径( ` --prefix`  )安装 IPython kernel spec。其中 ` --user` 与 `--prefix` 不能同时使用。
1. 使用 `--user` 时，IPython kernel spec 默认安装到当前用户 **~/.local/share/jupyter/kernels** 或者 **~/.ipython/kernels**。
1. 不加 `--user` 和 `--prefix` ，IPython kernel spec 默认安装到 **/usr/local/share/jupyter/kernels** 或者 **/usr/share/jupyter/kernels**。

IPython kernel spec 安装可以使用 `python -m ipykernel install` ，也可以使用 `ipython-kernel-install` 命令，两者是一样的。
