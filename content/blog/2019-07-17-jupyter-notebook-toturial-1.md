---
title: 数据科学工具 Jupyter Notebook 教程(一)
category: 开发
date: 2019-07-17T03:38:57.000Z
tags: Jupyter
published: true
---

iPython Notebook 是一个基于浏览器的 python 数据分析工具，使用起来非常方便，具有极强的交互方式和富文本的展示效果。Jupyter 是它的升级版，它的安装也非常方便，一般 Anaconda 安装包中会自带。安装好以后直接输入 jupyter notebook 便可以在浏览器中使用。<br />
<br />关于为什么使用 jupyter 进行分析，而不是用 python 脚本或仅仅利用 excel，这里列举知乎中的两点回答：<br />

> **1、基于过程**
> 
> 
> 数据分析和传统的 MVC 软件开发的最大区别在于，数据分析存在一个 data flow, 我们是在不断的做计算，并且画图。这里存在一个大致的 "顺序"，比如：
> 
> 1. 先对数据进行处理，去掉有问题的数据 (Data Wrangling)
> 1. 从各个角度看一个这个数据各个维度的分布情况 (Data Exploration)
> 1. 根据自己的想法、要求，做具体的分析，计算
> 1. 对计算结果做进一部分的分析<br />
> 
> 这有点类似做应用题。而这是传统的 IDE (e.g. PyCharm) 没有办法做到的。假如全部都写脚本+输出，那么你 **每张图可能都要保存下来，然后再单独点进去看**，很麻烦。而 Notebook 做这个要更方便，结果直接产生在 Cell 下面。<br />
![](https://qiniu.bioinit.com/yuque/0/2019/jpeg/126032/1563349363620-ffefa127-e6f7-49a3-ad26-87a50d6161df.jpeg#align=left&display=inline&height=437&originHeight=437&originWidth=656&size=0&status=done&width=656)<br />
反言之，如果你不需要这种频繁的计算-画图的话，那么 notebook 可能还真没什么大不了.

**2、Hackable**


和第一点对应，Notebook 的是计算+文档的混合体，而本身又是 web-based，因此非常好 hack, 比如我的 notebook 因为非常长，所以就加了个侧边栏目录：
> ![](https://qiniu.bioinit.com/yuque/0/2019/jpeg/126032/1563349415635-8a354789-7303-4b76-9a79-5deb0ac006b4.jpeg#align=left&display=inline&height=783&originHeight=783&originWidth=502&size=0&status=done&width=502)


再比如，在分析电影数据的时候，我觉得用 card 来展示更方便一点，所以可以这样显示数据：
> ![](https://qiniu.bioinit.com/yuque/0/2019/jpeg/126032/1563349446691-7c04adc4-2f8e-45d7-88ff-89f23ad37c5a.jpeg#align=left&display=inline&height=429&originHeight=429&originWidth=805&size=0&status=done&width=805)



<a name="I7DKO"></a>
# 安装

正常情况下，Anaconda 安装包中已经自带了 jupyter、jupyter-notebook。对于 Miniconda，或者其他只安装了 python 的机器，需要借助 pip 安装：
```bash
pip install ipython
pip install jypyter
```

或者使用 conda 命令安装：
```bash
conda install jupyter
```

更多安装说明，请参考 [官网](http://jupyter.org/install.html)。


<a name="UJFsH"></a>
# 启动

接下来，我们只需要在命令行输入 jupyter notebook 或者 jupyter-notebook 即可。

- 指定 ip 及端口启动 jupyter notebook
```bash
jupyter notebook --ip=0.0.0.0 --port=8080
```

- 启动 jupyter notebook 时不启动浏览器
```bash
jupyter notebook --no-browser
```

- 启动 jupyter notebook
```bash
$ jupyter-notebook 
[I 10:47:32.588 NotebookApp] JupyterLab alpha preview extension loaded from /Bio/Bioinfo/Pipeline/SoftWare/Python/Anaconda2.5/lib/python2.7/site-packages/jupyterlab
JupyterLab v0.27.0
Known labextensions:
[I 10:47:32.626 NotebookApp] Running the core application with no additional extensions or settings
[I 10:47:32.644 NotebookApp] Serving notebooks from local directory: /Bio/home/bi.shenwy/pythonTrain
[I 10:47:32.644 NotebookApp] 0 active kernels 
[I 10:47:32.644 NotebookApp] The Jupyter Notebook is running at: http://localhost:8888/?token=120a457da88d214270e...22a376d3d4
[I 10:47:32.644 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 10:47:32.651 NotebookApp] 
    
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=120a457da88d214270e...22a376d3d4
```

这时候，jupyter 会自动生成一个用于登陆 jupyter Notebook 的 token，我们在浏览器打开这个 token 链接即可进入登陆后的 Jupyter Notebook：<br />![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563350481111-cf547695-a543-48db-ae24-99be9d1e22ba.png#align=left&display=inline&height=342&originHeight=342&originWidth=807&size=0&status=done&width=807)



<a name="W6UZJ"></a>
# 使用

在 Jupyter Notebook web 页面，我们可以点击 "New" → "Python2" 创建 python2 笔记。<br />![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563350203434-e78b0a11-ea24-4634-ab10-29ccd5851a87.png#align=left&display=inline&height=342&originHeight=342&originWidth=807&size=0&status=done&width=807)


我们可以在创建好的笔记中使用 markdown 语法进行编辑，也可以交互执行 python 代码。<br />![](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563350417528-a1f23c74-5cc1-4c0d-9b01-db095db048f2.png#align=left&display=inline&height=356&originHeight=356&originWidth=806&size=0&status=done&width=806)

想要退出笔记，点击右上角 "Logout" 可退出；通过输入上面的 token 可重新登陆。或者我们可以通过 `jupyter notebook password` 命令设置密码进行登陆（如果忘记密码也可以通过该命令进行重置）。默认 jupyter notebook passwd 保存在 ~/.jupyter/jupyter_notebook_config.json。
```
$ cat ~/.jupyter/jupyter_notebook_config.json
{
  "NotebookApp": {
    "password": "sha1:1a611a30d93a:5ab8b4be55d5e.....b8c7a8sa"
  }
}
```
<a name="AbsTq"></a>
# 
以上就是本地 Jupyter Notebook 安装与使用的一些简单介绍，下一篇我们介绍一下 Jupyter Notebook 远程服务安装和配置。

