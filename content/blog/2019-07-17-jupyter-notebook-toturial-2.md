---
title: 数据科学工具 Jupyter Notebook 教程(二)
types: post
tags: ["Jupyter", "开发"]
date: 2019-07-17T07:48:42.000Z
category: 开发
published: true
---

上一篇文章中，我们介绍了 Jupyter Notebook 在本地的一些安装和使用，今天我们介绍一下 Python3+Nginx+SSL 下的 Jupyter Notebook 服务部署，也就是 Jupyter 服务器的搭建与配置。

网上搜了一下 jupyter 服务器的搭建，官方给出了很好的多用户服务端 jupyterhub，但我的需求就是在 VPS 搭建好一个 jupyter 服务网页，完全自己用，所以搭建 jupyterhub 有些浪费资源，转而去寻找简单的 jupyter 服务搭建方案，别说，官网也写好文档给我们用了，但文档是用英文写的，看的不舒服，这里把要点写出来，供参考。

[英文文档地址在此](http://jupyter-notebook.readthedocs.io/en/latest/public_server.html)，英文好的小伙伴可以直接去实施。


<a name="96b470cf"></a>
## 1. 安装

Jupyter Notebook 的安装参考《[数据科学工具 Jupyter Notebook 教程(一)](https://www.yuque.com/shenweiyan/cookbook/jupyter-notebook-toturial-1)》。


<a name="da8f18ee"></a>
## 2. 配置

下面的命令会在 `~/.jupyter` 自动创建一个配置文件 ** jupyter_notebook_config.py**。
```bash
$ jupyter notebook --generate-config
Writing default config to: /home/shenweiyan/.jupyter/jupyter_notebook_config.py
```

可以配置的项目有很多，有时间的话，可以仔细阅读配置文件中的注释，写的很清楚。

这里要强调的是创建密码的方法，总不想让自己的 jupyter 服务器被其他人使用吧。执行下面语句：
```bash
$ python -c "import IPython;print(IPython.lib.passwd())"
Enter password: 
Verify password: 
sha1:bda74221176f:ae266f5xxxxxxxxxxxxxxxxxxxxxxxx1
```

然后将得到的 sha1 复制到配置文件 jupyter_notebook_config.py 中的相应位置：
```bash
c.NotebookApp.password = 'sha1:bda74221176f:ae266f5xxxxxxxxxxxxxxxxxxxxxxxx1'
```

配置文件中，还有几处要修改：
```bash
c.NotebookApp.ip = '127.0.0.1'   # ip 为 localhost 会引发 OSError: [Errno 99] Cannot assign requested address
c.NotebookApp.allow_origin = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8888
```

如此这般之后，配置完成咯！


<a name="4c763bb6"></a>
## 3. 运行

执行命令，就可以看到 jupyter notebook 执行的日志信息：
```bash
$ jupyter notebook
[I 14:57:17.197 NotebookApp] JupyterLab beta preview extension loaded from /usr/local/software/anaconda3/lib/python3.6/site-packages/jupyterlab
[I 14:57:17.197 NotebookApp] JupyterLab application directory is /usr/local/software/anaconda3/share/jupyter/lab
[I 14:57:17.203 NotebookApp] Serving notebooks from local directory: /data/JupyterNotebook
[I 14:57:17.203 NotebookApp] 0 active kernels
[I 14:57:17.203 NotebookApp] The Jupyter Notebook is running at:
[I 14:57:17.203 NotebookApp] http://127.0.0.1:8888/
[I 14:57:17.203 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
```

这是尚不能打开网页，因为是配置在 127.0.0.1 上的，只有本机可以访问。如果想要通过 ip 预览一下 Jupyter Notebook，可以考虑使用 `--ip` 和 `--port` 启动：
```bash
$ jupyter notebook --ip=0.0.0.0 --port=9000
[I 16:12:57.449 NotebookApp] Serving notebooks from local directory: /apps/jupyter
[I 16:12:57.449 NotebookApp] The Jupyter Notebook is running at:
[I 16:12:57.449 NotebookApp] http://ecs-steven:9000/
[I 16:12:57.449 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).

```

如果在启动过程中出现：OSError: [Errno 99] Cannot assign requested address，请参考下面的方法解决。<br />!(https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563351248558-4c343f89-968f-4a50-aade-c227b3f70b77.png#align=left&display=inline&height=322&originHeight=322&originWidth=937&size=0&status=done&width=937)

**解决：**运行 Jupyter 时增加 `--ip=0.0.0.0` 参数。
```
jupyter notebook --ip=0.0.0.0 --no-browser --allow-root
```


<a name="5d50cc51"></a>
## 4. 域名解析

配置 nginx 前需要把你已经申请的域名跟 Jupyter Notebook 的服务器 ip 进行绑定解析。打开阿里云域名管理，增加 A 记录解析：

!(https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563334760254-00323543-edb8-4b95-8d6a-fb88595aef5a.png#align=left&display=inline&height=398&originHeight=398&originWidth=736&size=0&status=done&width=736)

<a name="5f33f177"></a>
## 5. 配置 nginx

Nginx 是一个高效的服务器，著名的 LNMP 中的 N，相信很多在 VPS 搭建过网站的小伙伴一定不陌生。我假设你已经安装好了 nginx，如果不会安装可以自行百度。

Nginx 创建一个虚拟主机 vhost，然后配置文件参考下面：
```bash
upstream notebook {
    server localhost:8888;
}
server {
    listen 80;
    server_name xxx.xxxx.com;
    rewrite ^/(.*) https://xxx.xxxx.com/$1 permanent;
}
server{
    listen 443 ssl;
    index index.html index.htm index.php default.html default.htm default.php;
    server_name xxx.xxxx.com;
    root /home/wwwroot/xxx.xxxx.com;            
    ssl_certificate /etc/letsencrypt/live/xxx.xxxx.com/fullchain.pem;    
    ssl_certificate_key /etc/letsencrypt/live/xxx.xxxx.com/privkey.key;   
    ssl_ciphers "EECDH CHACHA20:EECDH CHACHA20-draft:EECDH AES128:RSA AES128:EECDH AES256:RSA AES256:EECDH 3DES:RSA 3DES:!MD5";
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    location / {
        proxy_pass            http://notebook;
        proxy_set_header      Host $host;
    }
 
    location ~ /api/kernels/ {
        proxy_pass            http://notebook;
        proxy_set_header      Host $host;
        # websocket support
        proxy_http_version    1.1;
        proxy_set_header      Upgrade "websocket";
        proxy_set_header      Connection "Upgrade";
        proxy_read_timeout    86400;
    }
    location ~ /terminals/ {
        proxy_pass            http://notebook;
        proxy_set_header      Host $host;
        # websocket support
        proxy_http_version    1.1;
        proxy_set_header      Upgrade "websocket";
        proxy_set_header      Connection "Upgrade";
        proxy_read_timeout    86400;
    }
}
```

其中 **fullchain.pem** 与 **privkey.pem** 是你的网址的 SSL 证书，如果没有，可以参考 Letsencrypt 免费证书。

至此，大功告成，打开你的网址 **xxx.xxx.com** 是不是可以看到熟悉的 jupyter 了呢？如有疑问，欢迎留言讨论。

![jupyter_server.png](https://qiniu.bioinit.com/yuque/0/2019/png/126032/1563341527122-326cddb2-b2b2-4ccf-8b01-f2c03cca27e2.png#align=left&display=inline&height=577&name=jupyter_server.png&originHeight=577&originWidth=829&size=27393&status=done&width=829)

以上就是远程 Jupter Notebook 服务安装与配置的全部内容，下一篇我们介绍一下如何在  Jupyter Notebook  中使用不同内核（Kernel）实现支持包括 python2、python3、R 在的多种不同编程环境。
