---
title: Hugo 博客折腾的一些记录
type: post
tags: ["杂谈", "开发"]
date: 2019-08-08T09:05:21.000Z
category: 开发
published: true
---

模仿 R 语言大神谢益辉，搭建了一个 Hugo+rblogdown 的博客：[https://blog.bioinit.com](https://blog.bioinit.com/)

![hugo.png](https://note-db.oss-cn-shenzhen.aliyuncs.com/yuque/0/2019/png/126032/1565574651727-e9dc560f-fc43-4758-a227-9b8c343424d0.png#align=left&display=inline&height=660&name=hugo.png&originHeight=660&originWidth=1049&size=121639&status=done&width=1049)

主要记录：

- `.Site.BaseURL` 不起作用， `relURL` 、 `absURL` 也不起作用时，可参考使用 `params` 方法解决。
- 修复原博客 url 的一些 bug，[blog.bioinit.com](blog.bioinit.com) 部分链接被直接写死，想要复用的需要重新定义。


---

<a name="yKxV0"></a>
### CentOS 7 安装 Go

```bash
$ wget https://dl.google.com/go/go1.12.7.linux-amd64.tar.gz
$ tar zvxf go1.12.7.linux-amd64.tar.gz
$ mv go go-1.12.7

$ vi ~/.bashrc
# 在文件最后一行加入以下内容
export GOPATH=/ifs1/go-projects                #这个是你自己开发的GO代码位置，以后开发可以放这个目录下
export GOROOT=/usr/local/software/go-1.12.7    #这个就是我们安装的位置了。
export PATH=$PATH:$GOROOT/bin                  #go语言一些常用的命令引入PATH环境变量

$ go env 		# 查看 Go 的一些环境配置
```


<a name="yhPOe"></a>
### CentOS 7 安装 Hugo

```bash
$ wget https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.tar.gz
$ tar zvxf hugo_0.54.0_Linux-64bit.tar.gz -C /usr/local/software/hugo-0.54.0
$ echo "export PATH=/usr/local/software/hugo-0.54.0:\$PATH" >>~/.bashrc
$ source ~/.bashrc
```


<a name="IsvZa"></a>
### 启动 hugo 博客服务

```bash
shenweiyan@ecs-steven 15:04:06 ~/shenweiyan/home
$ hugo		# 渲染生成静态站点文件

                   | ZH
+------------------+-----+
  Pages            | 159
  Paginator pages  |   0
  Non-page files   |   2
  Static files     |  44
  Processed images |   0
  Aliases          |   0
  Sitemaps         |   1
  Cleaned          |   0

Total in 203 ms


$ hugo server --baseUrl=120.77.xx.xx --bind=0.0.0.0		# 启动本地预览服务
```


<a name="QdYub"></a>
### 一些问题

**问题：**<br />hugo-ivy 主题在 0.55 后版本的 Hugo 中 RSS 无法使用，并且在编译时会有如下警告：

```bash
Building sites … 
WARN 2019/08/13 09:03:08 Page's .URL is deprecated and will be removed in a future release. Use .Permalink or .RelPermalink. If what you want is the front matter URL value, use .Params.url.
WARN 2019/08/13 09:03:08 Page's .RSSLink is deprecated and will be removed in a future release. Use the Output Format's link, e.g. something like:
    {{ with .OutputFormats.Get "RSS" }}{{ .RelPermalink }}{{ end }}.
```


**方法：**<br />**

1. 网络部分关于将 `.URL` 相关的文件中 `.URL` 改成 `.Permalink` 以解决 `.URL` 的上述报错的做法（参考：《[LeaveIt以支持最新版Hugo](https://blog.hgtweb.com/2019/%E4%BF%AE%E5%A4%8Dleaveit%E4%BB%A5%E6%94%AF%E6%8C%81%E6%9C%80%E6%96%B0%E7%89%88hugo/)》），经测试如果针对 Menu 级别的 html 模板会引发其他错误；而且虽然 hugo 更新到了 0.56.3，但官方文档示例还在使用 `.URL` ，参考 [https://github.com/gohugoio/hugo/issues/5835](https://github.com/gohugoio/hugo/issues/5835)。

2. 修改包含 `.RSSLink` 相关的文件，如下：

```go
<!-- 修改前 -->
{{ if .RSSLink }}
    <link href="{{ .RSSLink | relURL }}" rel="alternate" type="application/rss+xml" title="{{ .Site.Title }}" />
{{ end }}

<!-- 修改后 -->
{{ with .OutputFormats.Get "RSS" }}
    <link href="{{ .RelPermalink | relURL }}" rel="alternate" type="application/rss+xml" title="{{ $.Title }}" />
{{ end }}
```

<a name="CiCYG"></a>
### 一些资料

记录一下，搭建部署过程中参考的一些资料：

- 钟浩光，《[用 R 语言的 blogdown+hugo+netlify+github 建博客](https://cosx.org/2018/01/build-blog-with-blogdown-hugo-netlify-github/)》，统计之都
- [[SOLVED] What should be used for the value of .Site.BaseURL?](https://discourse.gohugo.io/t/solved-what-should-be-used-for-the-value-of-site-baseurl/5896)
- chaomifan，《[Hugo+GitHub 静态博客折腾笔记](https://www.jianshu.com/p/076279c9ceea)》，简书
- Mogeko，《[链接为 Hugo 添加谈笑风生区 (Gitalk)](https://mogeko.me/2018/024/)》，Mogeko`s Blog
- ByQiu，《[为博客添加 Gitalk 评论插件](https://www.jianshu.com/p/78c64d07124d)》，简书
- Parsia，《[Archive Page in Hugo](https://parsiya.net/blog/2016-02-14-archive-page-in-hugo/)》，Hackerman's Hacking Tutorials

