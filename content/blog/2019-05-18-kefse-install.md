---
title: LEfSe 分析软件安装小记
types: post
tags: ["软件", "软件"]
date: 2019-05-18T12:43:17.000Z
category: 软件
published: true
---

<a name="5dc99f6e"></a>
## 问题

源码下载的 LEfSe，或者使用 `conda install -c bioconda lefse` 安装完成后，执行分析出现报错：
```
$ lefse-format_input.py hmp_aerobiosis_small.txt hmp_aerobiosis_small.in -c 1 -s 2 -u 3 -o 1000000

$ run_lefse.py hmp_aerobiosis_small.in hmp_aerobiosis_small.res
Number of significantly discriminative features: 51 ( 131 ) before internal wilcoxon
Number of discriminative features with abs LDA score > 2.0 : 51

$ lefse-plot_res.py hmp_aerobiosis_small.res hmp_aerobiosis_small.png
Traceback (most recent call last):
  File "/Bio/Bioinfo/Pipeline/SoftWare/Anaconda2/bin/lefse-plot_res.py", line 177, in <module>
    else: plot_histo_hor(params['output_file'],params,data,len(data['cls']) == 2,params['report_features'])
  File "/Bio/Bioinfo/Pipeline/SoftWare/Anaconda2/bin/lefse-plot_res.py", line 70, in plot_histo_hor
    ax = fig.add_subplot(111,frame_on=False,axis_bgcolor=params['back_color'])
  File "/Bio/Bioinfo/Pipeline/SoftWare/Anaconda2/lib/python2.7/site-packages/matplotlib/figure.py", line 1239, in add_subplot
    a = subplot_class_factory(projection_class)(self, *args, **kwargs)
  File "/Bio/Bioinfo/Pipeline/SoftWare/Anaconda2/lib/python2.7/site-packages/matplotlib/axes/_subplots.py", line 77, in __init__
    self._axes_class.__init__(self, fig, self.figbox, **kwargs)
  File "/Bio/Bioinfo/Pipeline/SoftWare/Anaconda2/lib/python2.7/site-packages/matplotlib/axes/_base.py", line 539, in __init__
    self.update(kwargs)
  File "/Bio/Bioinfo/Pipeline/SoftWare/Anaconda2/lib/python2.7/site-packages/matplotlib/artist.py", line 888, in update
    for k, v in props.items()]
  File "/Bio/Bioinfo/Pipeline/SoftWare/Anaconda2/lib/python2.7/site-packages/matplotlib/artist.py", line 881, in _update_property
    raise AttributeError('Unknown property %s' % k)
AttributeError: Unknown property axis_bgcolor
```

<a name="41dfb0bf"></a>
## 原因

出现报错主要原因是 matplotlib==2.2.0 起把部分功能函数移除了，我们需要回退 matplotlib 版本。

!(https://qiniu.bioinit.com/yuque/0/2019/png/126032/1558183433754-bec73a13-aa41-4753-a0e0-18c61d0e1a5a.png#align=left&display=inline&height=351&originHeight=351&originWidth=656&size=0&status=done&width=656)

```
$ python
Python 2.7.15 |Anaconda custom (64-bit)| (default, May  1 2018, 23:32:55)
[GCC 7.2.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import matplotlib
>>> matplotlib.__version__
'2.2.2'
>>>
```

<a name="4b86211f"></a>
## 解决

```
$ conda install matplotlib==2.1.1
```

<a name="add04619"></a>
## 重新测试

```
$ wget http://huttenhower.sph.harvard.edu/webfm_send/129 -O hmp_aerobiosis_small.txt

$ format_input.py hmp_aerobiosis_small.txt hmp_aerobiosis_small.in -c 1 -s 2 -u 3 -o 1000000

$ run_lefse.py hmp_aerobiosis_small.in hmp_aerobiosis_small.res

$ plot_res.py hmp_aerobiosis_small.res hmp_aerobiosis_small.png
```

!(https://qiniu.bioinit.com/yuque/0/2019/png/126032/1558183433779-08b46b37-6fa0-4cd7-9319-74d7c73bbfe0.png#align=left&display=inline&height=824&originHeight=824&originWidth=504&size=0&status=done&width=504)

问题解决！
